; Auto-generated. Do not edit!


(cl:in-package turtlebot_stage-msg)


;//! \htmlinclude roleSwitch.msg.html

(cl:defclass <roleSwitch> (roslisp-msg-protocol:ros-message)
  ((valid
    :reader valid
    :initarg :valid
    :type cl:boolean
    :initform cl:nil)
   (preID
    :reader preID
    :initarg :preID
    :type cl:integer
    :initform 0)
   (candidateID
    :reader candidateID
    :initarg :candidateID
    :type cl:integer
    :initform 0))
)

(cl:defclass roleSwitch (<roleSwitch>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <roleSwitch>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'roleSwitch)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name turtlebot_stage-msg:<roleSwitch> is deprecated: use turtlebot_stage-msg:roleSwitch instead.")))

(cl:ensure-generic-function 'valid-val :lambda-list '(m))
(cl:defmethod valid-val ((m <roleSwitch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:valid-val is deprecated.  Use turtlebot_stage-msg:valid instead.")
  (valid m))

(cl:ensure-generic-function 'preID-val :lambda-list '(m))
(cl:defmethod preID-val ((m <roleSwitch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:preID-val is deprecated.  Use turtlebot_stage-msg:preID instead.")
  (preID m))

(cl:ensure-generic-function 'candidateID-val :lambda-list '(m))
(cl:defmethod candidateID-val ((m <roleSwitch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot_stage-msg:candidateID-val is deprecated.  Use turtlebot_stage-msg:candidateID instead.")
  (candidateID m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <roleSwitch>) ostream)
  "Serializes a message object of type '<roleSwitch>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'valid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'preID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'preID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'preID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'preID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'candidateID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'candidateID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'candidateID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'candidateID)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <roleSwitch>) istream)
  "Deserializes a message object of type '<roleSwitch>"
    (cl:setf (cl:slot-value msg 'valid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'preID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'preID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'preID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'preID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'candidateID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'candidateID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'candidateID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'candidateID)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<roleSwitch>)))
  "Returns string type for a message object of type '<roleSwitch>"
  "turtlebot_stage/roleSwitch")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'roleSwitch)))
  "Returns string type for a message object of type 'roleSwitch"
  "turtlebot_stage/roleSwitch")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<roleSwitch>)))
  "Returns md5sum for a message object of type '<roleSwitch>"
  "e59b48a6f485ff9e719f4a2c1a1a9528")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'roleSwitch)))
  "Returns md5sum for a message object of type 'roleSwitch"
  "e59b48a6f485ff9e719f4a2c1a1a9528")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<roleSwitch>)))
  "Returns full string definition for message of type '<roleSwitch>"
  (cl:format cl:nil "bool valid~%uint32 preID~%uint32 candidateID~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'roleSwitch)))
  "Returns full string definition for message of type 'roleSwitch"
  (cl:format cl:nil "bool valid~%uint32 preID~%uint32 candidateID~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <roleSwitch>))
  (cl:+ 0
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <roleSwitch>))
  "Converts a ROS message object to a list"
  (cl:list 'roleSwitch
    (cl:cons ':valid (valid msg))
    (cl:cons ':preID (preID msg))
    (cl:cons ':candidateID (candidateID msg))
))
