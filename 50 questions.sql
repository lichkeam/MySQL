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


/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */