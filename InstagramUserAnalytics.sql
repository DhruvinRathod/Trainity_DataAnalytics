--Result:
--Here I would like to mention the list of questions and result I carried out based on the requirnments.

--Question  1: Find the 5 oldest users of the Instagram from the database provided
SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

 

--2. Find the users who have never posted a single photo on Instagram
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;


--3:  Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
--Your Task: Identify the winner of the contest and provide their details to the team
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;
 
--4: Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
--Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform


SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 


 

--5: Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
--Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 7;
 
--B) Investor Metrics: Our investors want to know if Instagram is performing well and is not becoming redundant like Facebook, they want to assess the app on the following grounds
--1.	User Engagement: Are users still as active and post on Instagram or they are making fewer posts
--Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users
 
--2.	Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts
--Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).

SELECT users.id,username, COUNT(users.id) As total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);
