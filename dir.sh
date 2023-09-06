
#!/bin/bash
for i in {1..100}
do
	mkdir test $i
	echo "this is file $i" > test$i /file$i
done
