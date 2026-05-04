# world_layoff_EDTA
During the late 2019 to late 2023 the world experienced a pandemic that led to companies lay off some of their employees. The layoffs were due to reduced operations and also in an attempt to reduce the spread of the corona virus. The analysis looks deep into the patterns and how the layoffs occurred during the pandemic

Q1. Write a query to remove all the null values  
The null values in this data set will not help in carrying out proper analysis of the data set and therefore the most convenient step is to delete the null values. All the null values have been correctly eliminated and our dataset is set for analysis.
DELETE FROM layoffs_copy2
WHERE total_laid_off is NULL
and percentage_laid_off IS NULL;

Q2. Write a query to show the maximum number of layoffs and Maximum Percentage layoff
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_copy2;

Q3. Write a query to display all the companies that laid off all their employees 
SELECT * FROM layoffs_copy2
WHERE percentage_laid_off =1;
Q4. Write a query to display the amount of funds raised by the companies that laid off all their employees 
SELECT * 
FROM layoffs_copy2 
WHERE percentage_laid_off =1 
ORDER BY funds_raised_millions DESC;

Q5.Write a query to display companies and the total number of employees laid off 
SELECT company, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY company  
ORDER BY 2 DESC;

Q6. Write a query to determine the start and end date of the laying off period 
SELECT MIN(`DATE`), MAX(`DATE`)
FROM layoffs_copy2;

Q7. Write a query to display each industry with the total number of employees laid off 
SELECT industry, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY industry  
ORDER BY 2 DESC;

Q8. Write a query to display each country and the sum of employees laid off 
SELECT country, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY country  
ORDER BY 2 DESC;

Q9. Write a query to display the number of employees laid off in each year of the pandemic
SELECT year(`date`), sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY year(`date`) 
ORDER BY 1 DESC;

Q10. Write a query to display the stage of the company where the laying off happened 
SELECT stage, sum(total_laid_off) 
FROM layoffs_copy2
GROUP BY stage
ORDER BY 2 DESC;

Q11. Write a query to display the top five companies that laid off the most number of employees for each year.
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







