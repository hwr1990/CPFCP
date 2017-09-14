#include "iostream"
#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Twist.h"

#include <geometry_msgs/Vector3.h>
#include <nav_msgs/Odometry.h>
#include <turtlebot_stage/agentState.h>
#include <turtlebot_stage/roleSwitch.h>
#include <math.h>
#include<vector>



using namespace std;

#define PI 3.1415926
#define Num_Agent 5
#define senseRange 4
#define delta_T 0.1
#define c1 0.4
#define c2 0.2
#define epsilon 0.1
#define r 4
#define h 0.2
#define a 5
#define b 5
#define d 0.7
#define senseThreshold 3
#define MAXVALUE 100
#define D_vec 1

#define NONE 0
#define MISSIONAGENT 1
#define RELAYAGENT 2
#define CANDIDATEAGENT 3

#define BS 20

#define LEADER 13

geometry_msgs::Twist cmd_vel;
turtlebot_stage::agentState myState;
turtlebot_stage::roleSwitch roleswitch;

ros::Publisher vel_pub_;
ros::Subscriber state_sub_;
ros::Publisher state_pub_;

ros::Subscriber nb1State_sub_;
	
float* position_data;
float* velocity_data;


int uID;


float myNorm(float dx, float dy)
{
	return sqrt(dx*dx + dy*dy);
}



void stateCb(const nav_msgs::Odometry::ConstPtr& msg)
{

char filepath[100] ;
sprintf(filepath, "/home/exbot/catkin_ws_relay/src/turtlebot_stage/src/debug/state%d.txt",uID);
FILE *pFile=fopen(filepath,"a");
fprintf(pFile, "%lf %f %f\n", ros::Time::now().toSec(),msg->pose.pose.position.x,msg->pose.pose.position.y);
fclose(pFile);

    *(position_data + 2*uID) = msg->pose.pose.position.x;
    *(position_data + 2*uID+1) = msg->pose.pose.position.y;

	*(velocity_data + 2*uID) = msg->twist.twist.linear.x;
	*(velocity_data + 2*uID+1) = msg->twist.twist.linear.y;

    myState.odom.pose.pose.position.x = msg->pose.pose.position.x;
    myState.odom.pose.pose.position.y = msg->pose.pose.position.y;

	myState.odom.twist.twist.linear.x = msg->twist.twist.linear.x;
	myState.odom.twist.twist.linear.y = msg->twist.twist.linear.y;

	myState.uID = uID;

    state_pub_.publish(myState);
}

void nb1StateCb(const turtlebot_stage::agentState::ConstPtr& msg)
{

	int id = msg->uID;

	if (id != uID)
	{
		*(position_data + 2*id) = msg->odom.pose.pose.position.x;
		*(position_data + 2*id+1) = msg->odom.pose.pose.position.y;

		*(velocity_data + 2*id) = msg->odom.twist.twist.linear.x;
		*(velocity_data + 2*id+1) = msg->odom.twist.twist.linear.y;
	}
}

float vectorFieldX(float x, float y)
{
	int k = 1;
	int s = 1;
	float fx  = 2*(x-7);
	float fy = 2*(y-7);
	float func = (y - 7)*(y - 7) + (x-7)*(x-7);

	if (func > 36 || func < 16) 
	{
        if (func > 36) func = func - 36;
        else func = func - 16;
        float vec_u = 1/sqrt(fx*fx + fy*fy) * (-fx * tanh(k*(func)) + s*fy/cosh(k*(func)));
        return vec_u;
    }
	else 
	{
    	float vec_u_s = 1/sqrt(fx*fx + fy*fy) * fy;
    	return vec_u_s;
	}	
}
float vectorFieldY(float x, float y)
{
	int k = 1;
	int s = 1;
	float fx  = 2*(x-7);
	float fy = 2*(y-7);
	float func = (y - 7)*(y - 7) + (x-7)*(x-7);

	if (func > 36 || func < 16) 
	{
	    if (func > 36) func = func - 36;
        else func = func - 16;
    	float vec_v = 1/sqrt(fx*fx + fy*fy) * (-fy * tanh(k*(func)) - s*fx/cosh(k*(func)));
    	return vec_v;
	}
    else
    {
        float vec_v_s = 1/sqrt(fx*fx + fy*fy) * (-fx);
	    return vec_v_s;
    }

}

void MA_controller()
{
	int i = uID;
	float pos_i_X = *(position_data + 2*i);
	float pos_i_Y = *(position_data + 2*i+1);	
	float vel_i_X = *(velocity_data + 2*i);
	float vel_i_Y = *(velocity_data + 2*i+1);

	if (1)
	{
		float Fi_formation_X = 0;
		float Fi_formation_Y = 0;
		float Fi_flock_X = 0;
		float Fi_flock_Y = 0;
		
		float pos_goal_X = 18;
		float pos_goal_Y = 6;	
		float vel_goal_X = 0;
		float vel_goal_Y = 0;
		
		for(int j = 0; j < Num_Agent; j++)
		{
			float pos_j_X = *(position_data + 2*j);
			float pos_j_Y = *(position_data + 2*j+1);
			float vel_j_X = *(velocity_data + 2*j);
			float vel_j_Y = *(velocity_data + 2*j+1);

			float dist_ij = myNorm(pos_i_X - pos_j_X, pos_i_Y - pos_j_Y);
			if ((j != i) && (dist_ij < r) ) //distance less than a threshold, j is neighbor of i
			{
				float n_ij_X = (pos_j_X - pos_i_X) / dist_ij;
				float n_ij_Y = (pos_j_Y - pos_i_Y) / dist_ij;

				if ((dist_ij < senseRange) && (dist_ij > d))
				{
					Fi_formation_X = Fi_formation_X + (dist_ij - d)/((dist_ij - senseRange) * (dist_ij - senseRange)) * n_ij_X;
					Fi_formation_Y = Fi_formation_Y + (dist_ij - d)/((dist_ij - senseRange) * (dist_ij - senseRange)) * n_ij_Y;
				}
				else if (dist_ij < d)
				{
					Fi_formation_X = Fi_formation_X + 100 * (dist_ij - d) / dist_ij * n_ij_X;
					Fi_formation_Y = Fi_formation_Y + 100 * (dist_ij - d) / dist_ij * n_ij_Y;
				}
				else
				{
					Fi_formation_X = Fi_formation_X + 0;
					Fi_formation_Y = Fi_formation_Y + 0;
				}

	
			}
			if ((j != i) && (dist_ij < r)) //
			{
				float n_ij_X = (pos_j_X - pos_i_X) / dist_ij;
				float n_ij_Y = (pos_j_Y - pos_i_Y) / dist_ij;

				if (dist_ij < d)
				{
					Fi_formation_X = Fi_formation_X + 100 * (dist_ij - d) / dist_ij * n_ij_X;
					Fi_formation_Y = Fi_formation_Y + 100 * (dist_ij - d) / dist_ij * n_ij_Y;
				}
				else
				{
					Fi_formation_X = Fi_formation_X + 0;
					Fi_formation_Y = Fi_formation_Y + 0;
				}
	
			}
		}
		
		float Fi_goal_X = 0; 
		float Fi_goal_Y = 0; 
		int kk;
		if (1) 
		{
			Fi_goal_X = vectorFieldX(pos_i_X, pos_i_Y);
			Fi_goal_Y = vectorFieldY(pos_i_X, pos_i_Y);		
		}

		float acc_X = (0.1*Fi_formation_X + Fi_goal_X + 2*(0-vel_i_X));
		float acc_Y = (0.1*Fi_formation_Y + Fi_goal_Y + 2*(0-vel_i_Y));

		float dist_goal = myNorm(pos_i_X - pos_goal_X, pos_i_Y - pos_goal_Y);
		if (dist_goal < senseThreshold*0.5)
		{
			acc_X = (0.1*Fi_formation_X - c1 * (pos_i_X - pos_goal_X) - 2 * (vel_i_X - 0));
			acc_Y = (0.1*Fi_formation_Y - c1 * (pos_i_Y - pos_goal_Y) - 2 * (vel_i_Y - 0));
		}
		

		float vel_X = vel_i_X + acc_X * delta_T;
		float vel_Y = vel_i_Y + acc_Y * delta_T;

		cmd_vel.linear.x = vel_X;
		cmd_vel.linear.y = vel_Y;


	
	}
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "leader");

    ros::NodeHandle n_;

	ros::NodeHandle n_private("~");
	n_private.param("uID", uID, 0);


	position_data = (float *)malloc(sizeof(float) * Num_Agent * 2);	
	for (int i = 0; i < Num_Agent; i++)
	{
		*(position_data + 2*i) = 0;	
		*(position_data + 2*i + 1) = 0;			
	}
	
	velocity_data = (float *)malloc(sizeof(float) * Num_Agent * 2);	
	for (int i = 0; i < Num_Agent; i++)
	{
		*(velocity_data + 2*i) = 0;	
		*(velocity_data + 2*i + 1) = 0;			
	}


    vel_pub_ = n_.advertise<geometry_msgs::Twist>("/robot/cmd_vel", 5);
	state_sub_ = n_.subscribe("ground_truth_state", 10, stateCb);
	state_pub_ = n_.advertise<turtlebot_stage::agentState>("myAgentState", 5);

    nb1State_sub_ = n_.subscribe("nb1_ground_truth_state", 10, nb1StateCb);

	sleep(5);
    ros::Rate loop_rate(10);
    while(ros::ok())
    {
        ros::spinOnce(); 

        MA_controller();
        vel_pub_.publish(cmd_vel);
        loop_rate.sleep();
    }

    return 0;
}
