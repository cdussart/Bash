# Returns the reverse of a given state
reverse_state()
{
    [[ "$1" == "~" ]] && echo "*" || echo "~"
}
  
# Updates the grid according to the number of the button that was pressed
update_states()
{
  button_nr=$1
  to_be_updated=()
  
  case $button_nr in
    1)
      to_be_updated="1 2 4 5"
      ;;
    2)
      to_be_updated="1 2 3"
      ;;
    3)
      to_be_updated="2 3 5 6"
      ;;
    4)
      to_be_updated="1 4 7"
      ;;
    5)
      to_be_updated="2 4 5 6 8"
      ;;
    6)
      to_be_updated="3 6 9"
      ;;
    7)
      to_be_updated="4 5 7 8"
      ;;
    8)
      to_be_updated="7 8 9"
      ;;
    9)
      to_be_updated="5 6 8 9"
      ;;
  esac

  for e in $to_be_updated; do
    states[$e]=`reverse_state ${states[$e]}`
  done
  
}
  
# Retrieve user inputs
IFS= read -r row1
IFS= read -r row2
IFS= read -r row3
IFS= read -r allButtonsPressed

# Store the inputs in a grid
IFS=' ' read -ra states <<< "0 $row1 $row2 $row3"

# Process the buttons pressed by the user
nb_buttons_pressed=${#allButtonsPressed}
for (( i=0; i<$nb_buttons_pressed; i++ )); do
  update_states ${allButtonsPressed:$i:1}
done
    
# Find the number that needs to be pressed to win
answer=-1
if [ "${states[1]}" == "~" -a "${states[2]}" == "~" -a "${states[4]}" == "~" -a "${states[5]}" == "*" ]; then
    answer=1
elif [ "${states[1]}" == "~" -a "${states[2]}" == "~" -a "${states[3]}" == "~" ]; then
    answer=2
elif [ "${states[2]}" == "~" -a "${states[3]}" == "~" -a "${states[5]}" == "*" -a "${states[6]}" == "~" ]; then
    answer=3
elif [ "${states[1]}" == "~" -a "${states[4]}" == "~" -a "${states[7]}" == "~" ]; then
    answer=4
elif [ "${states[2]}" == "~" -a "${states[5]}" == "*" -a "${states[8]}" == "~" -a "${states[4]}" == "~" -a "${states[6]}" == "~" ]; then
    answer=5
elif [ "${states[3]}" == "~" -a "${states[6]}" == "~" -a "${states[9]}" == "~" ]; then
    answer=6
elif [ "${states[4]}" == "~" -a "${states[5]}" == "*" -a "${states[7]}" == "~" -a "${states[8]}" == "~" ]; then
    answer=7
elif [ "${states[7]}" == "~" -a "${states[8]}" == "~" -a "${states[9]}" == "~" ]; then
    answer=8
elif [ "${states[5]}" == "*" -a "${states[6]}" == "~" -a "${states[8]}" == "~" -a "${states[9]}" == "~" ]; then
    answer=9
fi

echo $answer