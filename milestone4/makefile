java:
	/bin/rm -f -r lex.yy.* new.tab.* new_p.tab.* a.out *.o *.dot *.png *.output log.txt outputSymTabs output3AC assembly assembly.*
	bison -v -d -t --report=all new_p.y -Wno-conflicts-sr -Wno-other
	flex new_lex.l
	g++ new_p.tab.c lex.yy.c -Wno-write-strings

ast:
	@read -p "filename : " NAME && \
	echo "strict graph{ " > ast.dot && \
	./out < tests/test_$${NAME}.java >> ast.dot && \
	echo "}" >> ast.dot && \
	dot -Tpng ast.dot > output/test_$${NAME}.png

st:
	if [ -d outputSymTabs ]; then \
		rm -r outputSymTabs; \
	fi
	if [ ! -d output3AC ]; then \
		mkdir output3AC; \
	fi
	@read -p "filename : " NAME && \
	echo "Logs :  " > log.txt && \
	./a.out < tests/test_$${NAME}.java >> log.txt

asm:
	g++ 3ac_asm.cpp -o asm
	./asm

gcc:
	gcc -c assembly.s -o assembly.o
	gcc -o assembly assembly.o -no-pie
	./assembly

clean:
	/bin/rm -f -r lex.yy.* new.tab.* new_p.tab.* a.out *.o *.dot *.png *.output log.txt outputSymTabs output3AC assembly assembly.*