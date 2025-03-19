read a b c d e f
for((;i++<$a-1;));{
read h k
g[$h]=$k
}
g[$a-1]=$e
for((;;));{
l=WAIT
m=LEFT
read n o p
q=${g[$n]}
[ $o != $q ]&&{
[ $o -lt $q ]&&m=RIGHT;[ $p != $m ]&&l=BLOCK
}
echo $l
}