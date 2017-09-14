# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "turtlebot_stage: 3 messages, 0 services")

set(MSG_I_FLAGS "-Iturtlebot_stage:/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Inav_msgs:/opt/ros/indigo/share/nav_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/indigo/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(turtlebot_stage_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg" NAME_WE)
add_custom_target(_turtlebot_stage_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "turtlebot_stage" "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg" ""
)

get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg" NAME_WE)
add_custom_target(_turtlebot_stage_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "turtlebot_stage" "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg" "geometry_msgs/Point:geometry_msgs/PoseWithCovariance:geometry_msgs/TwistWithCovariance:geometry_msgs/Vector3:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Twist:nav_msgs/Odometry:geometry_msgs/Pose"
)

get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg" NAME_WE)
add_custom_target(_turtlebot_stage_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "turtlebot_stage" "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlebot_stage
)
_generate_msg_cpp(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/indigo/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlebot_stage
)
_generate_msg_cpp(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlebot_stage
)

### Generating Services

### Generating Module File
_generate_module_cpp(turtlebot_stage
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlebot_stage
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(turtlebot_stage_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(turtlebot_stage_generate_messages turtlebot_stage_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_cpp _turtlebot_stage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_cpp _turtlebot_stage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_cpp _turtlebot_stage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(turtlebot_stage_gencpp)
add_dependencies(turtlebot_stage_gencpp turtlebot_stage_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS turtlebot_stage_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlebot_stage
)
_generate_msg_lisp(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/indigo/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlebot_stage
)
_generate_msg_lisp(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlebot_stage
)

### Generating Services

### Generating Module File
_generate_module_lisp(turtlebot_stage
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlebot_stage
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(turtlebot_stage_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(turtlebot_stage_generate_messages turtlebot_stage_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_lisp _turtlebot_stage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_lisp _turtlebot_stage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_lisp _turtlebot_stage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(turtlebot_stage_genlisp)
add_dependencies(turtlebot_stage_genlisp turtlebot_stage_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS turtlebot_stage_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlebot_stage
)
_generate_msg_py(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/indigo/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlebot_stage
)
_generate_msg_py(turtlebot_stage
  "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlebot_stage
)

### Generating Services

### Generating Module File
_generate_module_py(turtlebot_stage
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlebot_stage
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(turtlebot_stage_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(turtlebot_stage_generate_messages turtlebot_stage_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/roleSwitch.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_py _turtlebot_stage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/agentState.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_py _turtlebot_stage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/exbot/catkin_ws_relay/src/turtlebot_stage/msg/wayPoint.msg" NAME_WE)
add_dependencies(turtlebot_stage_generate_messages_py _turtlebot_stage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(turtlebot_stage_genpy)
add_dependencies(turtlebot_stage_genpy turtlebot_stage_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS turtlebot_stage_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlebot_stage)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlebot_stage
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(turtlebot_stage_generate_messages_cpp std_msgs_generate_messages_cpp)
add_dependencies(turtlebot_stage_generate_messages_cpp nav_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlebot_stage)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlebot_stage
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(turtlebot_stage_generate_messages_lisp std_msgs_generate_messages_lisp)
add_dependencies(turtlebot_stage_generate_messages_lisp nav_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlebot_stage)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlebot_stage\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlebot_stage
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(turtlebot_stage_generate_messages_py std_msgs_generate_messages_py)
add_dependencies(turtlebot_stage_generate_messages_py nav_msgs_generate_messages_py)
