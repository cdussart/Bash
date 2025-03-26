#### FUNCTION BEGIN
# Echoes the distance between two points, being given the (x,y) coordinates of these two points.
# ARGUMENTS: 
# x1 : x of the first point
# y1 : y of the first point
# x2 : x of the second point
# y2 : y of the second point
# OUTPUTS: 
# 	The distance between the two given points
### FUNCTION END
function get_distance()
{
  x1=$1;x2=$2;y1=$3;y2=$4
  distance_x_square=`echo "$(( $x2 - $x1 ))^2" | bc`
  distance_y_square=`echo "$(( $y2 - $y1 ))^2" | bc`
  res=`echo "sqrt($distance_x_square + $distance_y_square)" | bc`
  echo $res
}

# Game loop
while true; do

  read -r x y # my coordinates
  read -r humanCount # number of remaining humans

  # Locate all humans
  for (( i=0; i<$humanCount; i++ )); do
        read -r humanId humanX humanY
    done

  # Locate all zombies and calculate the distance with each of them
  read -r zombieCount
  nearest_coordinate_x=-1
  nearest_coordinate_y=-1
  nearest_distance=30000
  for (( i=0; i<$zombieCount; i++ )); do
    read -r zombieId zombieX zombieY zombieXNext zombieYNext
    distance_i=$(get_distance $zombieXNext $zombieYNext $x $y)
    if [ $distance_i -lt $nearest_distance ]; then
      nearest_distance=$distance_i
      nearest_coordinate_x=$zombieXNext
      nearest_coordinate_y=$zombieYNext
    fi
  done

  # Go to nearest zombie
  echo $nearest_coordinate_x $nearest_coordinate_y
  
done