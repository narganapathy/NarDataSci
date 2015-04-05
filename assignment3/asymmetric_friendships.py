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
    key = record[0]
    value = record[1]
    mr.emit_intermediate(key, value)
    mr.emit_intermediate(value, key)

def reducer(key, list_of_friends):
    # key: word
    # value: list of occurrence counts
    friends_set = set();
    for person in list_of_friends:
	# detect duplicates and remove them
        if (person in friends_set):
		friends_set.remove(person);
	else:
		friends_set.add(person);
    for person in friends_set:
	    mr.emit((key, person));
 	
	

# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
