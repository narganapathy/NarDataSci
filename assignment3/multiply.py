import MapReduce
import sys

"""
Word Count Example in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    matrixname = record[0]
    row = record[1]
    col = record[2]
    val = record[3]
    if (matrixname == 'a'):
	    for i in range(5):
    	    	mr.emit_intermediate(str(row) + ":" +  str(i), record);
    elif (matrixname == 'b'):
	    for i in range(5):
    	    	mr.emit_intermediate(str(i) + ":" +  str(col), record);


def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    rowcol = key.split(":");
    row = int(rowcol[0]);
    col = int(rowcol[1]);
    matrixa = [];
    matrixb = [];
    for item in list_of_values:
	    if (item[0] == 'a'):
		    matrixa.append(item);
	    else:
		    matrixb.append(item);

    sum = 0;
    for aitem in matrixa:
	    for bitem in matrixb:
		# If A's col matches B's row
		if (aitem[2] == bitem[1]):
			sum = sum + (aitem[3] * bitem[3]);

    mr.emit((row, col, sum));
      	
	

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
