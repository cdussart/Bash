read nbFloors width nbRounds exitFloor exitPos nbTotalClones
for((;i++<$nbFloors-1;));{
read elevatorFloor elevatorPos
elevators[$elevatorFloor]=$elevatorPos
}
elevators[$nbFloors-1]=$exitPos
for((;;));{
action=WAIT
right_direction=LEFT
read cloneFloor clonePos cloneDirection
exit_position=${elevators[$cloneFloor]}
[ $clonePos != $exit_position ]&&{
[ $clonePos -lt $exit_position ]&&right_direction=RIGHT
[ $cloneDirection != $right_direction ]&&action=BLOCK
}
echo $action
}