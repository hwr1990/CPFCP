
(cl:in-package :asdf)

(defsystem "turtlebot_stage-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :nav_msgs-msg
)
  :components ((:file "_package")
    (:file "roleSwitch" :depends-on ("_package_roleSwitch"))
    (:file "_package_roleSwitch" :depends-on ("_package"))
    (:file "wayPoint" :depends-on ("_package_wayPoint"))
    (:file "_package_wayPoint" :depends-on ("_package"))
    (:file "agentState" :depends-on ("_package_agentState"))
    (:file "_package_agentState" :depends-on ("_package"))
  ))