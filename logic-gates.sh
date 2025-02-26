
# A logic gate is an electronic device implementing a boolean function, performing a logical operation on one or more binary inputs and producing a single binary output.
# Given n input signal names and their respective data, and m output signal names with their respective type of gate and two input signal names, provide m output signal names and their respective data, in the same order as provided in input description.
# All type of gates will always have two inputs and one output.
# All input signal data always have the same length.
# The type of gates are :
# AND : performs a logical AND operation.
# OR : performs a logical OR operation.
# XOR : performs a logical exclusive OR operation.
# NAND : performs a logical inverted AND operation.
# NOR : performs a logical inverted OR operation.
# NXOR : performs a logical inverted exclusive OR operation.
# Signals are represented with underscore and minus characters, an undescore matching a low level (0, or false) and a minus matching a high level (1, or true).

# Define the results for each gate type
output_bool()
{
  op="$1"
  signal1="$2"
  signal2="$3"
  case $op in
    AND)
      [[ $signal1 = "-" && $signal2 = "-" ]] && echo "-" || echo "_"
      ;;
    OR)
      [[ $signal1 = "-" || $signal2 = "-" ]] && echo "-" || echo "_"
      ;;
    XOR)
      [[ $signal1 != $signal2 ]] && echo "-" || echo "_"
      ;;
    NAND)
      [[ $signal1 = "_" || $signal2 = "_" ]] && echo "-" || echo "_"
      ;;
    NOR)
      [[ $signal1 = "_" && $signal2 = "_" ]] && echo "-" || echo "_"
      ;;
    NXOR)
      [[ $signal1 = $signal2 ]] && echo "-" || echo "_"
      ;;
    *)
      echo "_"
      ;;
  esac
}

# Initialization of variables
declare -A inputs
outputs=()

# Get the number of inputs and number of outputs
read -r n
read -r m

# Get the inputs from the user and store them.
# Example of input : "A __---_-__--_-"
# Store the inputs in an associative array, like $inputs[0] = array("A" => "__---_-__--_-")

for (( i=0; i<$n; i++ )); do
    read -r inputName inputSignal
    inputs[$inputName]=$inputSignal
done

# Get the outputs from the user and store them.
# Example of output : "C AND A B", so : output name, logic gate, and the two inputs we want to combine.
# Store the outputs in an associative array, like $outputs[0] = ["C", "AND", "A", "B"]

for (( i=0; i<$m; i++ )); do
    read -r outputName _type inputName1 inputName2
    outputs[$i]="$outputName;$_type;$inputName1;$inputName2"

done

# Echo the results
lastTrailingN=$m-1;
for (( i=0; i<$m; i++ )); do

    # Gather the data
    outputString=${outputs[$i]}
    IFS=";" read -r -a output <<< "${outputString}"
    outputName=${output[0]}
    signalType=${output[1]}
    inputName1=${output[2]}
    inputName2=${output[3]}
    inputSignal1=${inputs[$inputName1]}
    inputSignal2=${inputs[$inputName2]}

    # Hopefully, the signals will have the same length, but if not, we will stop outputting when the shorter input stops.
    length1=${#inputSignal1} 
    length2=${#inputSignal2}
    if [ "$length1" -eq "$length2" ]; then
        outputLength=$length1
    else
        if [ "$length1" -lt "$length2" ]; then
            outputLength=$length1 
        else
            outputLength=$length2
        fi
    fi

    # Echo the outputs
    res="$outputName "
    signal=""
    for (( iSignal=0; iSignal<$outputLength; iSignal++ )); do
        signal1=${inputSignal1:$iSignal:1}
        signal2=${inputSignal2:$iSignal:1}
        signal="${signal}`output_bool $signalType $signal1 $signal2`"
    done
    res="$res $signal"    
    echo $res
 
done