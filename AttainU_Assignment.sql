use `attainu_sql_assignment`;
Select * from users;
Select * from batches;
Select * from student_batch_maps;
Select * from instructor_batch_maps;
Select * from attendances;
Select * from sessions;
Select * from tests;
Select * from test_scores order by user_id,test_id;

-- Query I
select session_id,u.name,b.name,avg(rating) from attendances as a
join sessions as s
on a.session_id=s.id
left join student_batch_maps as m
on s.batch_id=m.batch_id
left join users u
on s.conducted_by=u.id
left join batches as b
on b.id=s.batch_id
where (m.deactivated_at<s.start_time or m.deactivated_at is NULL)
group by a.session_id
order by session_id asc;

-- *******************************************

Select * from student_batch_maps;

-- Query II
Select a.session_id,b.name,u.name as `conducted_by`,(count(distinct a.student_id)/count(distinct m.user_id)*100) as `attendance%` 
from attendances as a
left join sessions as s
on a.session_id=s.id
left join student_batch_maps as m
on s.batch_id=m.batch_id
left join batches as b
on m.batch_id=b.id
left join users as u
on s.conducted_by=u.id
where (m.deactivated_at<s.start_time or m.deactivated_at is NULL)
group by m.batch_id,a.session_id
order by a.session_id asc;

-- ******************************************

Select * from sessions as s
join student_batch_maps as m
on s.batch_id=m.batch_id
where (m.deactivated_at<s.start_time or m.deactivated_at is NULL);

Select * from student_batch_maps;

-- Query III
Select u.name,user_id,avg(score) from test_scores as ts
left join users as u
on ts.user_id=u.id
group by user_id order by user_id;

--********************************************

-- Query IV
Select ts.test_id,b.name,count(distinct user_id) as `count of passed students` from test_scores as ts
left join tests as t
on ts.test_id=t.id
left join batches as b
on t.batch_id=b.id
where ts.score>(t.total_mark*0.4)
group by t.id;

-- ******************************************

-- Query V
Select m.user_id,u.name,(count(!a.session_id)/(Select q1.count from (Select count(distinct s.id) as count,m.user_id  from student_batch_maps as m
left join sessions as s
on m.batch_id=s.batch_id
left join attendances as a
on s.id=a.session_id and m.user_id=a.student_id
where m.deactivated_at is not NULL and m.deactivated_at<start_time
group by m.user_id) as q1 where q1.user_id=m.user_id)*100) as `attendance%`from student_batch_maps as m
left join sessions as s
on m.batch_id=s.batch_id
left join attendances as a
on s.id=a.session_id and m.user_id=a.student_id
left join users as u
on a.student_id=u.id
where m.deactivated_at is not NULL and m.deactivated_at<start_time
group by m.user_id;
-- ****************************************************

-- Side Notes
Select * from users;
Select * from attendances where student_id=10;
Select * from sessions;
Select * from student_batch_maps;
Select a.student_id,count(a.student_id) as x,(Select count(batch_id) from sessions where m.batch_id=sessions.batch_id) as num,m.batch_id from attendances as a,student_batch_maps as m,sessions as s
where m.user_id=a.student_id group by student_id;


Select student_id,count(*) as `total_attendance` from attendances group by student_id;
Select user_id,batch_id from student_batch_maps where deactivated_at is not NULL;
Select count(batch_id) from sessions group by batch_id;
Select * from student_batch_maps;
Select * from sessions;
Select user_id,count(distinct s.id),m.batch_id from student_batch_maps as m
join sessions as s
on m.batch_id=s.batch_id
where deactivated_at is not NULL
group by m.batch_id;
-- (count(!a.rating)/count(distinct s.id)*100) as `attendance%`
Select q1.count from (Select count(distinct s.id) as count,m.user_id  from student_batch_maps as m
left join sessions as s
on m.batch_id=s.batch_id
left join attendances as a
on s.id=a.session_id and m.user_id=a.student_id
where m.deactivated_at is not NULL and m.deactivated_at<start_time
group by m.user_id) as q1 where q1.user_id=10;

Select user_id,(Select count(student_id) as freq from attendances)/count(s.batch_id),s.batch_id from student_batch_maps as m
left join sessions as s
on s.batch_id=m.batch_id
where m.active=0 and m.deactivated_at<s.start_time 
group by user_id,batch_id;

Select * from attendances;

select * from student_batch_maps;
