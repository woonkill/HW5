all: exprtest

exprtest: exprtest.o parser.tab.o driver.o scanner.o
	g++ -Wall -g -MMD -o exprtest exprtest.o driver.o parser.tab.o scanner.o

exprtest.o: exprtest.cpp expression.hpp driver.hpp
	g++ -Wall -MMD -c exprtest.cpp

parser.tab.o: expression.hpp scanner.hpp driver.hpp
	bison parser.ypp
	g++ -Wall -MMD -c parser.tab.cpp

driver.o: driver.cpp driver.hpp scanner.hpp
	g++ -Wall -MMD -c driver.cpp

scanner.o: scanner.ll scanner.hpp
	flex -t scanner.ll > scanner.cpp
	g++ -Wall -MMD -c scanner.cpp

clean:
	-rm -f *.d *.hh *.o *~ parser.cc parser.h parser.tab.cpp parser.tab.hpp scanner.cpp FlexLexer.h exprtest

