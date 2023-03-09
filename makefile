java:
	/bin/rm -f lex.yy.* new.tab.* out *.o *.dot *.png *.output
	bison -d -t --report=all  new.y
	flex new_lex.l
	g++ -O3 new.tab.c -c -Wno-write-strings
	g++ -O3 lex.yy.c -c -Wno-write-strings
	g++ -c ast.c++
	g++ -o out new.tab.o lex.yy.o ast.o
ast:
	@read -p "filename : " NAME \
	&& echo "strict graph{ " > ast.dot \
	&& ./out < tests/test_$${NAME}.java >> ast.dot \
	&& echo "}" >> ast.dot \
	&& dot -Tpng ast.dot > output/test_$${NAME}.png
clean:
	/bin/rm -f lex.yy.* new.tab.* out *.o *.dot *.png *.output
