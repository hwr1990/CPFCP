define kinect ranger
(
  sensor
  (
    range_max 6.5
    fov 270.0
    samples 640
  )
  # generic model properties
  color "black"
  size [ 0.06 0.15 0.03 ]
)

define topurg ranger
(
  sensor
  (
    range [0.0 2.0]
    fov 120.25
    samples 481
  )
  # generic model properties
  color "black"
  size [ 0.05 0.05 0.1 ]
)

define turtlebot position
(
  pose [ 0.0 0.0 0.0 0.0 ]

  odom_error [0.03 0.03 999999 999999 999999 0.02]

  size [ 0.1 0.1 0.40 ]
  origin [ 0.0 0.0 0.0 0.0 ]
  gui_nose 1
  drive "omni"
  color "gray"
  
#  kinect(pose [ -0.1 0.0 -0.11 0.0 ])
   topurg(pose [0.050 0.000 -0.050 0.000])
)
