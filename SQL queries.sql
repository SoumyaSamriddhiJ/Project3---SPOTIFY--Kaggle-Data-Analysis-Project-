-- Filter: time filter

-- KPIs:
-- 1. distinct track count
select count(distinct track_id) as tracks_cnt FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
-- 2. distinct artist count
select count(distinct artist_name) as artists_cnt FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
-- 3. Avg track duration
select round(avg(track_duration_min),3)  as track_duration_min FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
-- 4. distinct generes count
select count(distinct artist_genres) as artist_genres_cnt FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
-- 5. distinct albums count
select count(distinct album_id) as album_cnt FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 

-- Metrics:
-- 1. Artist name wise tracks count
select artist_name , track_cnt , dense_rank() over (order by track_cnt desc) as rnk
from (
select artist_name , count(distinct track_id) as track_cnt
FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
group by artist_name )
order by track_cnt desc 
-- 2. top 5 popular tracks with artist name. 
select * from(select track_id	,track_name,	track_popularity	,	artist_name , dense_rank() over (order by track_popularity desc) as rnnk
FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
order by track_popularity desc 
) where rnnk <=10 order by track_popularity desc
-- 3. Top 5 Generes , track count wise.
select * from(select artist_genres , albums_cnt ,  dense_rank() over (order by albums_cnt desc) as rnnk from(
select 	artist_genres , count(distinct album_id) as albums_cnt
FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
group by artist_genres 
) )where rnnk <=10 order by albums_cnt  desc
-- 4. Top 5 most followed artist name.
select artist_name ,	avg(artist_followers)  as artist_followers
from  `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
group by 1 order by 2 desc
-- 5. Avg track duration of an artist i.e sum(total_duration_in_min)/ count(distinct track_id)
select artist_name ,	avg(track_duration_min)  as track_duration_min
from  `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
group by 1 order by 2 desc
-- 6. Artist with their (distinct track count) & (distinct album id count)
1.select artist_name , count(distinct album_id) as album_cnt --, count(distinct track_id) as track_cnt
FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
group by artist_name 
order by album_cnt desc 
limit 10
2.select artist_name , count(distinct track_id) as track_cnt
FROM `data-and-reporting-ccmm.Master_Google_Sheet.tb1` 
group by artist_name 
order by track_cnt desc 
limit 10


