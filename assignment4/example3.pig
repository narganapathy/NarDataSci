register s3n://uw-cse-344-oregon.aws.amazon.com/myudfs.jar

-- load the test file into Pig
raw = LOAD 's3n://uw-cse-344-oregon.aws.amazon.com/cse344-test-file' USING TextLoader as (line:chararray);
-- later you will load to other files, example:
--raw = LOAD 's3n://uw-cse-344-oregon.aws.amazon.com/btc-2010-chunk-000' USING TextLoader as (line:chararray); 

-- parse each line into ntriples
ntriples = foreach raw generate FLATTEN(myudfs.RDFSplit3(line)) as (subject:chararray,predicate:chararray,object:chararray);
ntriples1 = foreach raw generate FLATTEN(myudfs.RDFSplit3(line)) as (subject2:chararray,predicate2:chararray,object2:chararray);

-- Filter the list based on the match
filtered_list = filter ntriples by (subject matches '.*business.*');
filtered_list2 = filter ntriples1 by (subject2 matches '.*business.*') ;

-- Join the two lists
joined_list = join filtered_list by subject,filtered_list2 by subject2;


-- remove duplicates
final_list = distinct joined_list;

store final_list into '/user/hadoop/join-example' using PigStorage();
-- Alternatively, you can store the results in S3, see instructions:
-- store count_by_object_ordered into 's3n://superman/example-results';

