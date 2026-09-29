SELECT COUNT(*)
FROM video_games;

SELECT
    COUNT(*) AS total_games,
    ROUND(SUM(global_sales), 2) AS total_global_sales,
    ROUND(AVG(global_sales), 2) AS avg_sales_per_game
FROM video_games;
--Использовал агрегатные функции COUNT, SUM и AVG, чтобы получить основные показатели датасета.

SELECT
    genre,
    ROUND(SUM(global_sales), 2) AS total_sales
FROM video_games
GROUP BY genre
ORDER BY total_sales DESC;
--Самые успешные жанры

SELECT
    platform,
    ROUND(SUM(global_sales), 2) AS total_sales
FROM video_games
GROUP BY platform
ORDER BY total_sales DESC
LIMIT 10;
--Лучшие платформы

SELECT
    name,
    platform,
    year_of_release,
    global_sales
FROM video_games
ORDER BY global_sales DESC
LIMIT 10;
--Самые продаваемые игры

SELECT
    publisher,
    ROUND(SUM(global_sales), 2) AS total_sales
FROM video_games
WHERE publisher IS NOT NULL
GROUP BY publisher
ORDER BY total_sales DESC
LIMIT 10;
--Лучшие издатели

SELECT
    genre,
    COUNT(*) AS games_count,
    ROUND(AVG(global_sales), 2) AS avg_sales
FROM video_games
GROUP BY genre
HAVING COUNT(*) > 100
ORDER BY avg_sales DESC;
--Жанры с высокими средними продажами (HAVING)

SELECT
    name,
    global_sales,
    CASE
        WHEN global_sales >= 10 THEN 'Mega Hit'
        WHEN global_sales >= 5 THEN 'Hit'
        WHEN global_sales >= 1 THEN 'Popular'
        ELSE 'Regular'
    END AS success_category
FROM video_games
ORDER BY global_sales DESC
LIMIT 20;
--Категории успешности игр (CASE)

SELECT
    genre,
    name,
    platform,
    global_sales
FROM (
    SELECT
        genre,
        name,
        platform,
        global_sales,
        ROW_NUMBER() OVER (
            PARTITION BY genre
            ORDER BY global_sales DESC
        ) AS rn
    FROM video_games
    WHERE genre IS NOT NULL
) ranked
WHERE rn = 1
ORDER BY global_sales DESC;
--Оконная функция (ROW_NUMBER)


