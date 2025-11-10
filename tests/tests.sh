#!/bin/sh


run_normal_test()
{
	$file=$1
	if $file > /dev/null; then
		echo "OK: $file"
	else
		echo "FAILED: $file"
		run_valgrind_test $file
		exit 1
	fi
}

run_valgrind_test()
{
	$file=$1
	if valgrind --show-leak-kinds=all --leak-check=full -s --error-exitcode=1 $file > /dev/null; then
		echo "Valgrind OK: $file"
	else
		echo "Valgrind ERROR: $file"
		exit 2
	fi
}

echo "Running Standart Tests..."

for file in out/tests/*.out
do
	run_normal_test $file
done

echo "=============================="

echo "Running Valgrind Test..."

for file in $(pwd)/out/tests/*.out
do

	run_valgrind_test $file

done


