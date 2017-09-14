; Auto-generated. Do not edit!


(cl:in-package turtlebot_stage-msg)


;//! \htmlinclude agentState.msg.html

(cl:defclass <agentState> (roslisp-msg-protocol:ros-message)
  ((agent_role
    :reader agent_role
    :initarg :agent_role
    :type cl:integer
    :initform 0)
   (uID
    :reader uID
    :initarg :uID
    :type cl:integer
    :initform 0)
   (odom
    :reader odom
    :initarg :odom
    :type nav_msgs-msg:Odometry
    :initform (cl:make-instance 'nav_msgs-msg:Odometry))
   (degree
    :reader degree
    :initarg :degree
    :type cl:integer
    :initform 0)
   (isAP
    :reader isAP
    :initarg :isAP
    :type cl:integer
    :initform 0))
)

(cl:defclass agentState (<agentState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <agentState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'agentState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name turtlebot_stage-msg:<agentState> is deprecated: use turtlebot_stage-msg:agentState instead.")))

(cl:ensure-generic-function 'agent_role-val :lambda-list '(m))
(cl:defmethod agent_role-val ((m <agentState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:agent_role-val is deprecated.  Use turtlebot_stage-msg:agent_role instead.")
  (agent_role m))

(cl:ensure-generic-function 'uID-val :lambda-list '(m))
(cl:defmethod uID-val ((m <agentState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:uID-val is deprecated.  Use turtlebot_stage-msg:uID instead.")
  (uID m))

(cl:ensure-generic-function 'odom-val :lambda-list '(m))
(cl:defmethod odom-val ((m <agentState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:odom-val is deprecated.  Use turtlebot_stage-msg:odom instead.")
  (odom m))

(cl:ensure-generic-function 'degree-val :lambda-list '(m))
(cl:defmethod degree-val ((m <agentState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:degree-val is deprecated.  Use turtlebot_stage-msg:degree instead.")
  (degree m))

(cl:ensure-generic-function 'isAP-val :lambda-list '(m))
(cl:defmethod isAP-val ((m <agentState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:isAP-val is deprecated.  Use turtlebot_stage-msg:isAP instead.")
  (isAP m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <agentState>) ostream)
  "Serializes a message object of type '<agentState>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'agent_role)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'agent_role)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'agent_role)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'agent_role)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'uID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'uID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'uID)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'odom) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'degree)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'degree)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'degree)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'degree)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'isAP)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'isAP)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'isAP)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'isAP)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <agentState>) istream)
  "Deserializes a message object of type '<agentState>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'agent_role)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'agent_role)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'agent_role)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'agent_role)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'uID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'uID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'uID)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'odom) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'degree)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'degree)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'degree)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'degree)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'isAP)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'isAP)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'isAP)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'isAP)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<agentState>)))
  "Returns string type for a message object of type '<agentState>"
  "turtlebot_stage/agentState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'agentState)))
  "Returns string type for a message object of type 'agentState"
  "turtlebot_stage/agentState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<agentState>)))
  "Returns md5sum for a message object of type '<agentState>"
  "2aad78d9b6be9facf3d860a8a1c79738")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'agentState)))
  "Returns md5sum for a message object of type 'agentState"
  "2aad78d9b6be9facf3d860a8a1c79738")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<agentState>)))
  "Returns full string definition for message of type '<agentState>"
  (cl:format cl:nil "uint32 agent_role~%uint32 uID~%nav_msgs/Odometry odom~%uint32 degree~%uint32 isAP~%~%================================================================================~%MSG: nav_msgs/Odometry~%# This represents an estimate of a position and velocity in free space.  ~%# The pose in this message should be specified in the coordinate frame given by header.frame_id.~%# The twist in this message should be specified in the coordinate frame given by the child_frame_id~%Header header~%string child_frame_id~%geometry_msgs/PoseWithCovariance pose~%geometry_msgs/TwistWithCovariance twist~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistWithCovariance~%# This expresses velocity in free space with uncertainty.~%~%Twist twist~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'agentState)))
  "Returns full string definition for message of type 'agentState"
  (cl:format cl:nil "uint32 agent_role~%uint32 uID~%nav_msgs/Odometry odom~%uint32 degree~%uint32 isAP~%~%================================================================================~%MSG: nav_msgs/Odometry~%# This represents an estimate of a position and velocity in free space.  ~%# The pose in this message should be specified in the coordinate frame given by header.frame_id.~%# The twist in this message should be specified in the coordinate frame given by the child_frame_id~%Header header~%string child_frame_id~%geometry_msgs/PoseWithCovariance pose~%geometry_msgs/TwistWithCovariance twist~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistWithCovariance~%# This expresses velocity in free space with uncertainty.~%~%Twist twist~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <agentState>))
  (cl:+ 0
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'odom))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <agentState>))
  "Converts a ROS message object to a list"
  (cl:list 'agentState
    (cl:cons ':agent_role (agent_role msg))
    (cl:cons ':uID (uID msg))
    (cl:cons ':odom (odom msg))
    (cl:cons ':degree (degree msg))
    (cl:cons ':isAP (isAP msg))
))
