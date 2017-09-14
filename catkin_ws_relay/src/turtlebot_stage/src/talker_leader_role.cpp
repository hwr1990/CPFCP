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
#define Num_Agent 9
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
#define MISSIONROBOT 1
#define RELAYROBOT 2
#define SCOUTROBOT 3

#define BS 20

#define LEADER 13

geometry_msgs::Twist cmd_vel;
turtlebot_stage::agentState myState;
turtlebot_stage::roleSwitch roleswitch;

ros::Publisher vel_pub_;
ros::Subscriber state_sub_;
ros::Publisher state_pub_;

ros::Subscriber roleSwitch_sub_;
ros::Publisher roleSwitch_pub_;

ros::Subscriber nb1State_sub_;
ros::Subscriber nb2State_sub_;
ros::Subscriber nb3State_sub_;
ros::Subscriber nb4State_sub_;
	
float* position_data;
float* velocity_data;
int* agent_role;
int* degree_data;
int* isAP_data;

int uID;
int initRole;
int preID;
int preNode;
int sucID;
float centre_X;
float centre_Y;

float wayPoints_X[5] = {3,8,13,18,23};
float wayPoints_Y[5] = {5,8,5,8,5};
int indWP;

void roleSwitchCb(const turtlebot_stage::roleSwitch::ConstPtr& msg)
{
	if ((msg->candidateID == uID) && (msg->valid == true))
	{
		*(agent_role + uID) = SCOUTROBOT;
		preID = msg->preID;
	}

}

float myNorm(float dx, float dy)
{
	return sqrt(dx*dx + dy*dy);
}

typedef struct mymypair
{
	int id;
	float bearing;
}mypair;

typedef struct myemptySector
{
	int id1;
	int id2;
	float sectorAngle;
}emptySector;


int isArticulationPoint()
{
	int i = uID;
	float pos_i_X = *(position_data + 2*i);
	float pos_i_Y = *(position_data + 2*i+1);

	vector<mypair> vec;
	
	for (int j = 0; j < Num_Agent; j++)
	{
		float pos_j_X = *(position_data + 2*j);
		float pos_j_Y = *(position_data + 2*j+1);

		float dist_ij = myNorm(pos_i_X - pos_j_X, pos_i_Y - pos_j_Y);
		if ((j != i) && (dist_ij < r) && (agent_role[j] == MISSIONROBOT))
		{
			float myBearing = atan2(pos_j_Y - pos_i_Y, pos_j_X - pos_i_X);
			mypair newPair;
			newPair.id = j;
			newPair.bearing = myBearing;

			if (vec.size() == 0)
			{
				vec.push_back(newPair);
			}
			else
			{
				vector<mypair>::iterator it;
				int insertIndex = 0;
				for (it = vec.begin(); it != vec.end(); it++)
				{
					if (myBearing < (*it).bearing)
						break;
					insertIndex++;
				}
				vec.insert(vec.begin()+insertIndex, newPair);
			}

		}
	}

	if (vec.size() != 0)
	{
		vector<mypair>::iterator itBegin = vec.begin();
		mypair newPair;
		newPair.id = (*itBegin).id;
		newPair.bearing = (*itBegin).bearing + 2*PI;
		vec.push_back(newPair);

		// compute emptySector
		vector<emptySector> emptySectorVector;

		vector<mypair>::iterator it;
		for (it = vec.begin(); it != vec.end()-1; it++)
		{
			int Ni = (*it).id;
			int Nj = (*(it+1)).id;
			float mySectorAngle = (*(it+1)).bearing - (*it).bearing;

			if (mySectorAngle >= PI)
			{		
				emptySector newEmptySector;
				newEmptySector.id1 = Ni;
				newEmptySector.id2 = Nj;
				newEmptySector.sectorAngle = mySectorAngle;
				emptySectorVector.push_back(newEmptySector);
			}
			else
			{
				float pos_Ni_X = *(position_data + 2*Ni);
				float pos_Ni_Y = *(position_data + 2*Ni+1);
				float pos_Nj_X = *(position_data + 2*Nj);
				float pos_Nj_Y = *(position_data + 2*Nj+1);
				float dist_NiNj = myNorm(pos_Ni_X - pos_Nj_X, pos_Ni_Y - pos_Nj_Y);
				if (dist_NiNj > r)
				{
					emptySector newEmptySector;
					newEmptySector.id1 = Ni;
					newEmptySector.id2 = Nj;
					newEmptySector.sectorAngle = mySectorAngle;
					emptySectorVector.push_back(newEmptySector);
				}

			}
		}

		return (emptySectorVector.size() > 1 ? 1:0);
	}

	return 0;//emptySectorVector.size() > 1 ? 1:0;
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
	myState.agent_role = *(agent_role + uID);
	myState.uID = uID;

	int myDegree = 0;
	float pos_i_X = *(position_data + 2*uID);
	float pos_i_Y = *(position_data + 2*uID+1);
	for(int j = 0; j < Num_Agent; j++)
	{
		float pos_j_X = *(position_data + 2*j);
		float pos_j_Y = *(position_data + 2*j+1);

		float dist_ij = myNorm(pos_i_X - pos_j_X, pos_i_Y - pos_j_Y);
		if ((j != uID) && (dist_ij < r) && ((agent_role[j] == MISSIONROBOT)  || (agent_role[j] == SCOUTROBOT))) //distance less than a threshold, j is neighbor of i
			myDegree++;
	}
	*(degree_data + uID) = myDegree;
	myState.degree = myDegree;
	myState.isAP = isArticulationPoint();




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

		*(agent_role + id) = msg->agent_role;
		*(degree_data + id) = msg->degree;
		*(isAP_data + id) = msg->isAP;
	}
}




float sigmaNorm(float dx, float dy)
{
	return (sqrt(1 + epsilon * myNorm(dx,dy) * myNorm(dx,dy)) - 1) / epsilon;
}

float sigma_1Norm(float z)
{
	return (z / sqrt(1 + z*z));
}

float rouHFunc(float z)
{
	if ((z>=0) && (z<h))
		return 1;
	else if ((z>=h) && (z<1))
		return (0.5 * (1 + cos(PI * (z - h) / (1 - h))));
	else 
		return 0; 
}

float phi(float z)
{
    float c = (a - b) / sqrt(4 * a * b);
    float phi_val = 0.5 * ((a + b) * sigma_1Norm(z + c) + (a - b));
	return phi_val;
}
float phiAlpha(float z)
{
	float rAlpha = sigmaNorm(r,0);
	float dAlpha = sigmaNorm(d,0);
	return (rouHFunc(z / rAlpha) * phi(z - dAlpha));
}

float vectorField(float x, float y, float Ax, float Ay, float Bx, float By)
{
	int k = 1;
	float slope = (By - Ay) / (Bx - Ax);
	float slope_angle = atan2(By - Ay, Bx - Ax);
	float desireCourse = -atan(k * ((y - Ay) - slope * (x - Ax)) / sqrt(1+slope*slope)) + slope_angle;
	return (tan(desireCourse));
}

float vectorFieldX(float x, float y)
{
	int k = 1;
	int s = 1;
	float fx  = -1 * cos(0.5*x);
	float fy = 1;
	float func = y - 2 * sin(0.5*x) - 5;

	int ss = 0;
	if (func > 0) ss = 1;
	else ss = -1;

	float vec_u = 1/sqrt(fx*fx + fy*fy) * (-fx * tanh(k*(func - ss*D_vec)) + s*fy/cosh(k*(func - ss*D_vec)));
	float vec_u_s = 1/sqrt(fx*fx + fy*fy) * fy;
	return (fabs(func) > D_vec ? vec_u : vec_u_s);
}
float vectorFieldY(float x, float y)
{
	int k = 1;
	int s = 1;
	float fx  = -1 * cos(0.5*x);
	float fy = 1;
	float func = y - 2 * sin(0.5*x) - 5;

	int ss = 0;
	if (func > 0) ss = 1;
	else ss = -1;

	float vec_v = 1/sqrt(fx*fx + fy*fy) * (-fy * tanh(k*(func - ss*D_vec)) - s*fx/cosh(k*(func - ss*D_vec)));
	float vec_v_s = 1/sqrt(fx*fx + fy*fy) * (-fx);
	return (fabs(func) > D_vec ? vec_v : vec_v_s);
}

void MA_controller()
{
	int i = uID;
	float pos_i_X = *(position_data + 2*i);
	float pos_i_Y = *(position_data + 2*i+1);	
	float vel_i_X = *(velocity_data + 2*i);
	float vel_i_Y = *(velocity_data + 2*i+1);

	if ((agent_role[i] == MISSIONROBOT) || (agent_role[i] == SCOUTROBOT))
	{
		float Fi_formation_X = 0;
		float Fi_formation_Y = 0;
		float Fi_flock_X = 0;
		float Fi_flock_Y = 0;
		
		float pos_goal_X = 18;
		float pos_goal_Y = 5.324;	
		float vel_goal_X = 0;
		float vel_goal_Y = 0;
		
		for(int j = 0; j < Num_Agent; j++)
		{
			float pos_j_X = *(position_data + 2*j);
			float pos_j_Y = *(position_data + 2*j+1);
			float vel_j_X = *(velocity_data + 2*j);
			float vel_j_Y = *(velocity_data + 2*j+1);

			float dist_ij = myNorm(pos_i_X - pos_j_X, pos_i_Y - pos_j_Y);
			if ((j != i) && (dist_ij < r) && ((agent_role[j] == MISSIONROBOT)  || (agent_role[j] == SCOUTROBOT))) //distance less than a threshold, j is neighbor of i
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
			if ((j != i) && (dist_ij < r) && ((agent_role[j] == RELAYROBOT))) //
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
		if (1) // (agent_role[i] == SCOUTROBOT)
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

	if (agent_role[i] == SCOUTROBOT)
	{
		float pos_i_X = position_data[2*i];
		float pos_i_Y = position_data[2*i+1];	
		
		// compute distance between scout and neighbor relay network
		float minDist = MAXVALUE;

		if (preID == BS)
			minDist = myNorm(pos_i_X - 0, pos_i_Y - 5);
		else
		{
			float pos_pre_X = position_data[2*preID];
			float pos_pre_Y = position_data[2*preID+1];

			minDist = myNorm(pos_i_X - pos_pre_X, pos_i_Y - pos_pre_Y);
		}
	
		if (minDist > senseThreshold)  // switch role from scout to relay
		{
			agent_role[i] = RELAYROBOT;

			// decide the succeed node 
			float maxD = 0;
			float minX = 100;
			int sucNode = 100;
			int sucNode1 = 100; // if all of neighbors is AP and isnot leader
			int sucNode2 = 100; // if all of neighbors is AP and one is leader
			int sucNode3 = 100; // if one of neighbors isnot AP and isnot leader
			int numNeighbor = 0;
			for(int j = 0; j < Num_Agent; j++)
			{
				float pos_j_X = position_data[2*j];
				float pos_j_Y = position_data[2*j+1];

				float dist_ij = myNorm(pos_i_X - pos_j_X, pos_i_Y - pos_j_Y);
			
				if ((dist_ij < senseRange) && (agent_role[j] == MISSIONROBOT)) //distance less than a threshold, j is neighbor of i, j is not a relay
				{
					numNeighbor++;
					sucNode1 = j;

					if (j == LEADER) sucNode2 = j;

					if ((j != LEADER) && (isAP_data[j] == 0) && (pos_j_X < minX))
					{
						sucNode3 = j;
						minX = pos_j_X;

//						break; // need break when select a noAP randly
					}
				}
			}

			if (sucNode3 != 100) sucNode = sucNode3;
			else{
				if (sucNode2 != 100) sucNode = sucNode2;
				else sucNode = sucNode1;
			}

			if (sucNode != 100)	
			{
				sucID = sucNode;
				roleswitch.valid = true;
				roleswitch.preID = uID;
				roleswitch.candidateID = sucNode;
				roleSwitch_pub_.publish(roleswitch);
			}
			else
			{
			}


			
		}		
	}
}

void RA_controller()
{

	int i = uID;
	if (agent_role[i] == RELAYROBOT)
	{
		
		float pos_i_X = position_data[2*i];
		float pos_i_Y = position_data[2*i+1];	
		float vel_i_X = velocity_data[2*i];
		float vel_i_Y = velocity_data[2*i+1];
		
		float pos_pre_X;
		float pos_pre_Y; 
		if (preID == BS)
		{
			pos_pre_X = 0;
			pos_pre_Y = 5;
		}
		else
		{
			pos_pre_X = position_data[2*preID];
			pos_pre_Y = position_data[2*preID+1];
		}

		float pos_suc_X = position_data[2*sucID];
		float pos_suc_Y = position_data[2*sucID+1];

// make relay agent move to the desire path

		float acc_X = (0.5*(pos_pre_X + pos_suc_X) - pos_i_X) + 2*(0-vel_i_X);
		float acc_Y = (0.5*(pos_pre_Y + pos_suc_Y) - pos_i_Y) + 2*(0-vel_i_Y);
		
		
		float vel_X = vel_i_X + acc_X * delta_T;
		float vel_Y = vel_i_Y + acc_Y * delta_T;
		
		cmd_vel.linear.x = vel_X;
		cmd_vel.linear.y = vel_Y;

	}
	
}
void RA_controller_inpath()
{

	int i = uID;
	if (agent_role[i] == RELAYROBOT)
	{
		
		float pos_i_X = position_data[2*i];
		float pos_i_Y = position_data[2*i+1];	
		float vel_i_X = velocity_data[2*i];
		float vel_i_Y = velocity_data[2*i+1];
		
		float pos_pre_X;
		float pos_pre_Y; 
		if (preID == BS)
		{
			pos_pre_X = 0;
			pos_pre_Y = 5;
		}
		else
		{
			pos_pre_X = position_data[2*preID];
			pos_pre_Y = position_data[2*preID+1];
		}

// make relay agent move to the desire path

		int k = 1;
		int s;
		float fx = 2 * (pos_i_X - pos_pre_X);
		float fy = 2 * (pos_i_Y - pos_pre_Y);
		float func = (pos_i_X - pos_pre_X) * (pos_i_X - pos_pre_X) + (pos_i_Y - pos_pre_Y) * (pos_i_Y - pos_pre_Y) - senseThreshold * senseThreshold;

		if (pos_i_Y - 2*sin(0.5*pos_i_X) - 5 > 0) s = 1;
		else s = -1;	

		float Fi_goal_X, Fi_goal_Y;
			
		Fi_goal_X = 1/sqrt(fx*fx + fy*fy) * (-fx * tanh(k*func) + s*fy/cosh(k*func));
		Fi_goal_Y = 1/sqrt(fx*fx + fy*fy) * (-fy * tanh(k*func) - s*fx/cosh(k*func));


		
		float acc_X = fabs(pos_i_Y - 2*sin(0.5*pos_i_X) - 5) * Fi_goal_X + 2*(0-vel_i_X);
		float acc_Y = fabs(pos_i_Y - 2*sin(0.5*pos_i_X) - 5) * Fi_goal_Y + 2*(0-vel_i_Y);

		
		float vel_X = vel_i_X + acc_X * delta_T;
		float vel_Y = vel_i_Y + acc_Y * delta_T;
		
		cmd_vel.linear.x = vel_X;
		cmd_vel.linear.y = vel_Y;
	}
	
}

void controller()
{
	int i = uID;
	if (agent_role[i] == MISSIONROBOT)
	{
		MA_controller();
	}
	else if (agent_role[i] == SCOUTROBOT)
	{
		MA_controller();
	}
	else if (agent_role[i] == RELAYROBOT)
	{
		RA_controller_inpath();
	}
	else cout<<"Has none role!"<<endl;
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "leader");

    ros::NodeHandle n_;

	ros::NodeHandle n_private("~");
	n_private.param("uID", uID, 0);
	n_private.param("initRole", initRole, 0);


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

	agent_role = (int *)malloc(sizeof(int) * Num_Agent);	
	for (int i = 0; i < Num_Agent; i++)
	{
		*(agent_role + i) = NONE;			
	}

	degree_data = (int *)malloc(sizeof(int) * Num_Agent);	
	for (int i = 0; i < Num_Agent; i++)
	{
		*(degree_data + i) = 0;			
	}

	isAP_data = (int *)malloc(sizeof(int) * Num_Agent);	
	for (int i = 0; i < Num_Agent; i++)
	{
		*(isAP_data + i) = 0;			
	}

	agent_role[uID] = initRole;
	preID = BS;

	indWP = 0;

        vel_pub_ = n_.advertise<geometry_msgs::Twist>("/robot/cmd_vel", 5);
	state_sub_ = n_.subscribe("ground_truth_state", 10, stateCb);
	state_pub_ = n_.advertise<turtlebot_stage::agentState>("myAgentState", 5);

	roleSwitch_sub_ = n_.subscribe("roleSwitch", 10, roleSwitchCb);
	roleSwitch_pub_ = n_.advertise<turtlebot_stage::roleSwitch>("roleSwitch", 5);

        nb1State_sub_ = n_.subscribe("nb1_ground_truth_state", 10, nb1StateCb);

	sleep(5);
    ros::Rate loop_rate(10);
    while(ros::ok())
    {
		ros::spinOnce(); 

		controller();
		vel_pub_.publish(cmd_vel);
        loop_rate.sleep();
    }

    return 0;
}
