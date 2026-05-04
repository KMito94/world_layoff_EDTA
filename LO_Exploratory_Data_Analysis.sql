-- Exploratory Data Analysis

-- Deleting NULL VALUES
SELECT * FROM layoffs_copy2;

DELETE FROM layoffs_copy2
WHERE total_laid_off is NULL
and percentage_laid_off IS NULL;

SELECT * FROM layoffs_copy2 
WHERE total_laid_off is NULL
and percentage_laid_off IS NULL;

SELECT MAX(total_laid_off) ,MAX(percentage_laid_off)
FROM layoffs_copy2;

SELECT * FROM layoffs_copy2
WHERE percentage_laid_off =1;

SELECT * 
FROM layoffs_copy2 
WHERE percentage_laid_off =1 
ORDER BY funds_raised_millions DESC;

SELECT company, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY company  
ORDER BY 2 DESC;

SELECT MIN(`DATE`) , MAX(`DATE`)
FROM layoffs_copy2;

SELECT industry, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY industry  
ORDER BY 2 DESC;

SELECT country, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY country  
ORDER BY 2 DESC;

SELECT  year(`date`), sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY  year(`date`) 
ORDER BY 1 DESC;

SELECT  stage, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY  stage
ORDER BY 2 DESC;

SELECT company,  YEAR(`date`), sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company,  YEAR(`date`), sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY company,YEAR(`date`)
), Company_Year_Rank AS
(
SELECT *, 
DENSE_RANK () OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
 SELECT *
 FROM Company_Year_Rank
 WHERE Ranking <=5;

