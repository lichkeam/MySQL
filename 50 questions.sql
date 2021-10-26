/*01 查詢" 01 "課程比" 02 "課程成績高的學生課程分數 */
SELECT * FROM Student s
where s.sid in (
    SELECT a.sid FROM SC a
    JOIN SC b on a.SId = b.SId 
    WHERE a.CId = '01'
    AND b.CId = '02'
    AND a.score > b.score)


/*02 查詢同時存在" 01 "課程和" 02 "課程的情況 */
SELECT * FROM SC a
JOIN SC b ON a.sid = b.sid
where a.CId = '01'
and b.CId = '02'


/*03 查詢存在" 01 "課程但可能不存在" 02 "課程的情況(不存在時顯示為 null )*/
SELECT * FROM 
(SELECT * FROM SC where CId = '01')a
LEFT JOIN 
(SELECT * FROM SC where CId = '02')b
on a.sid = b.sid


/*04 查詢不存在" 01 "課程但存在" 02 "課程的情況*/
SELECT * FROM SC
where SC.sid not in
      (select a.sid from SC a where a.cid = '01')
    and SC.cid = '02'


/*05 查詢平均成績大於等於60分的同學的學生編號和學生姓名和平均成績*/
SELECT s.sid, s.sname, avg(SC.score) as 'Average_Score'
FROM Student s
JOIN SC on s.sid = SC.sid
group by s.sid
HAVING avg(SC.score) > 60


/*06 查詢在 SC 表存在成績的學生信息*/
SELECT DISTINCT s.* FROM Student s
JOIN SC on s.sid = SC.sid


/*07 查詢所有同學的學生編號、學生姓名、選課總數、所有課程的總成績(沒成績的顯示為 null )*/
SELECT s.sid, s.sname, count(SC.cid), sum(SC.score)
FROM Student s 
LEFT JOIN SC on s.sid = SC.sid
GROUP BY s.sid


/*08 查有成績的學生信息*/
SELECT s.* FROM Student s
JOIN SC ON s.sid = SC.sid
GROUP BY s.sid
HAVING count(SC.cid) > 0

/*09 查詢「李」姓老師的數量*/
SELECT count(t.tid) FROM Teacher t
WHERE t.tname like '李%'

/*10 查詢學過「張三」老師授課的同學的信息*/
SELECT s.* FROM Student s
JOIN SC on s.sid = SC.sid 
JOIN Course c on SC.cid = c.cid
JOIN Teacher t on c.tid = t.tid
WHERE t.tname like '張三'

/*11 查詢沒有學全所有課程的同學的信息*/
SELECT s.* FROM Student s
LEFT JOIN SC on s.sid = SC.sid
GROUP BY s.sid
HAVING count(SC.cid) > 0 and count(SC.cid) < (SELECT * count(*) FROM Course)


/*12 查詢至少有一門課與學號為" 01 "的同學所學相同的同學的信息*/
SELECT DISTINCT s.* FROM Student s
JOIN SC on s.sid = SC.sid
where SC.cid in (SELECT SC.cid from SC where SC.sid = '01')

/*13 查詢和" 01 "號的同學學習的課程 完全相同的其他同學的信息*/
SELECT * FROM Student s
JOIN (SELECT b.SId, b.CId as 'CId1', b.score as 'score1' FROM SC b WHERE b.CId = '01')d ON d.sid = s.SId
JOIN (SELECT v.SId, v.CId as 'CId2', v.score as 'score2' FROM SC v WHERE v.CId = '02')e ON e.sid = d.SId

/*14 查詢沒學過"張三"老師講授的任一門課程的學生姓名*/
SELECT * from Student s
where s.SId not in (
    SELECT s.SId FROM Student s 
    JOIN SC on s.sid = SC.sid
    JOIN Course c on c.CId = SC.CId
    JOIN Teacher t on t.TId = c.TId
    where t.tname = '張三'
    )


/*15 查詢兩門及其以上不及格課程的同學的學號，姓名及其平均成績*/
SELECT s.SId, s.SName, AVG(SC.score) FROM Student s
JOIN SC on s.sid = SC.sid
WHERE SC.score < 60
GROUP BY s.SId
HAVING COUNT(SC.CId) >= 2

/*16 檢索" 01 "課程分數小於 60，按分數降序排列的學生信息*/
SELECT s.*, SC.score FROM Student s
JOIN SC on s.sid = SC.sid
WHERE SC.CId = '01' AND SC.CId < 60
ORDER BY SC.score DESC 


/*17 按平均成績從高到低顯示所有學生的所有課程的成績以及平均成績*/
SELECT SC.sid, s.Sname,
sum(case when SC.cid = '01' then SC.score else null end) as score_01,
sum(case when SC.cid = '02' then SC.score else null end) as score_02,
sum(case when SC.cid = '03' then SC.score else null end) as score_03,
avg(SC.score) from SC
JOIN Student s on s.SId = SC.SId
group by sid
order by avg(SC.score) desc

/*18 查詢各科成績最高分、最低分和平均分*/
SELECT SC.CId, c.Cname as CourseName, Count(SC.SId) N, MAX(SC.score)
MAX_Score, min(SC.score) MIN_Score, AVG(SC.score) AVG_Score,
(SUM(case when SC.score >= 60 then 1 else 0 end)/ count(SC.score)) PASS_Rate,
(SUM(case when SC.score >= 70 and SC.score < 80 then 1 else 0 end)/ count(SC.score)) OK,
(SUM(case when SC.score >= 80 and SC.score < 90 then 1 else 0 end)/ count(SC.score)) NICE,
(SUM(case when SC.score >= 90 then 1 else 0 end)/ count(SC.score)) EXCEL
FROM SC JOIN Course c on SC.CId = c.CId
GROUP BY SC.CId
ORDER BY COUNT(SC.CId) DESC



/*19 按各科成績進行排序，並顯示排名， Score 重復時合並名次*/
select a.cid, a.sid, a.score, COUNT(b.score) as ranks
from SC as a 
left join SC as b 
on a.score < b.score and a.cid = b.cid
GROUP BY a.CId, a.SId, a.score
ORDER BY a.CId, ranks

/*20 查詢學生的總成績，並進行排名，總分重復時不保留名次空缺*/
select sid, sum(score) as total,
row_number() over(order by sum(score) desc) as 'rank'
from SC
group by sid

/*21 統計各科成績各分數段人數：課程編號，課程名稱，
[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比*/
SELECT Course.CId, Course.Cname,t1.*
FROM Course LEFT JOIN (
select SC.CId,
CONCAT(sum(case when SC.score>=85 and SC.score<=100 then 1 else 0 end )/count(*)*100,'%') as '[85-100]',
CONCAT(sum(case when SC.score>=70 and SC.score<85 then 1 else 0 end )/count(*)*100,'%') as '[70-85)',
CONCAT(sum(case when SC.score>=60 and SC.score<70 then 1 else 0 end )/count(*)*100,'%') as '[60-70)',
CONCAT(sum(case when SC.score>=0 and SC.score<60 then 1 else 0 end )/count(*)*100,'%') as '[0-60)'
from SC
GROUP BY SC.CId) as t1 on course.CId = t1.CId


/*22 查詢各科成績前三名的記錄*/
select cid, sid, score from SC
where (select count(*) from SC a where a.cid = SC.cid
and a.score > SC.score) < 3
ORDER BY cid, score desc

/*23 查詢每門課程被選修的學生數*/
SELECT CId,COUNT(SC.CId) FROM SC
GROUP BY CId

/*24 查詢出只選修兩門課程的學生學號和姓名*/
SELECT t.SId, t.Sname FROM Student t
JOIN SC s on s.sid = t.sid
GROUP BY s.sid
HAVING COUNT(s.CId) = 2

/*25 查詢男生、女生人數*/
select ssex,count(sid) from Student 
group by ssex
/*  */
/*  */