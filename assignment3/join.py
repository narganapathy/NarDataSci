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
    key = record[1]
    value = record;
    mr.emit_intermediate(key, value)


def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    orderrow = []
    for row in list_of_values:
    	if (row[0] == "order"): 
		orderrow = row;
	elif (row[0] == "line_item"):
		finalrow = [];
		finalrow.extend(orderrow);
		finalrow.extend(row);
		mr.emit(finalrow);



# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
