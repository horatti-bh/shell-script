function test() {
    echo "Hello function, How are you?"
    echo "My name is $name"
    location=AnyWhere

}

test2() {
  echo "1st arguments $1"
  echo "2nd arguments $2"
  echo "All arguemnts $*"
  echo "Total arguments $#"
  return 77


}

name=BTH
test
echo "I am good to move $location"
test2 bb nummi yammi zummi
echo "exit code to $?"