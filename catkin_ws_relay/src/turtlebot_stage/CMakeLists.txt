cmake_minimum_required(VERSION 2.8.3)
project(turtlebot_stage)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  message_generation
  genmsg
  nav_msgs
)


add_message_files(
   FILES
   agentState.msg
   roleSwitch.msg
   wayPoint.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
  nav_msgs
)

catkin_package(
CATKIN_DEPENDS message_runtime
)

catkin_add_env_hooks(25.turtlebot-stage SHELLS sh DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/env-hooks)

install(DIRECTORY launch 
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY maps 
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY rviz 
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

add_executable(talker_leader src/talker_leader.cpp)
target_link_libraries(talker_leader ${catkin_LIBRARIES})
add_dependencies(talker_leader turtlebot_stage_generate_messages_cpp)


