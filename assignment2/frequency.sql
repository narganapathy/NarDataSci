-- prob 1c
-- select count (*) FROM (
-- select term from Frequency 
-- 	where (Frequency.docid="10398_txt_earn" AND Frequency.count=1) UNION ALL
-- select term from Frequency 
-- 	where (Frequency.docid="925_txt_trade" AND Frequency.count=1));

-- prob 1d

-- 	select count(Frequency.docid) from Frequency where (Frequency.term = "parliament");
-- prob 1e
-- nested query
-- 	select docid, doccount from (
-- 	select docid, SUM(count) as doccount from Frequency group by docid) where (doccount > 300);

-- prob 1e using HAVING statement
-- 	select docid, SUM(count) from Frequency group by docid having (SUM(count) > 300);

-- prob 1f (this is an intersection). this can be  modeled as a join
--	select v1 from 
--	(select docid as "v1" from Frequency where term = "transactions" )
--	join 
--	(select docid as "v2" from Frequency where term = "world")
--	on v1 = v2;

-- matrix multiplication

-- prob 1g
-- select a.row_num, b.col_num, SUM(a.value*b.value) from a join  b on a.col_num = b.row_num 
-- group by a.row_num,b.col_num;

-- Similarity matrix
-- prob 1h
-- it compares terms as the matrix is transposed.
-- select a.docid, b.docid, SUM(a.count*b.count) from frequency  as a join  frequency as b on a.term = b.term 
-- group by a.docid, b.docid;

--  keyword search

/*
create view v3 as 
	SELECT * FROM frequency
	UNION
	SELECT 'q' as docid, 'washington' as term, 1 as count 
	UNION
	SELECT 'q' as docid, 'taxes' as term, 1 as count
	UNION 
	SELECT 'q' as docid, 'treasury' as term, 1 as count;
*/


select * from (
	select a.docid, b.docid, SUM(a.count*b.count) as sum from v3 as a 
	join v3 as b on a.term = b.term group by a.docid ,b.docid) 
where docid = 'q' order by sum;


