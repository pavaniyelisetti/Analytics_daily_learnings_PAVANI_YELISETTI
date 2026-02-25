Today I learned subqueries and CTE from DataCamp, here is my notes from what I have learnt.

1. A subquery is a query inside another query, that can be used as an alternative to a join. You can place a subquery in each main section of the query; in the SELECT, FROM, and WHERE clauses. Subqueries are appealing because they can return a single result instead of a join's many rows. 
2. The subqueries doesn’t wait for the tables to be joined and then perform stats or functions, instead they allows you to perform without much time.
3. Where subqueries are dynamic filters. In the query execution plan, subqueries in SELECT and WHERE statements are analogous to joins. Subqueries in the FROM statement are not, limiting the optimization capacity. FROM subqueries are usually best rewritten as joins.

COMMON TABLE EXPRESSIONS:
1. Common table expressions, or CTEs, are another join alternative. A CTE is a standalone query that returns a temporary results set. The query is wrapped in a WITH function and the results referenced in later SELECT statements. CTEs are appealing for many of the same reasons as subqueries. They can return a single result and are more readable than a series of joins. Unlike subqueries, CTEs create a temporary table that is only executed one time. These temporary table  are advantageous when working with large or complex tables that are resource intensive to query.
2. To use multiple cte’s you can include 
With new-table-name as
(select…query continues)
, new-table-name2 as 
(select…query continues)

Example: WITH countries_cte AS
(
 SELECT olympic_cc
 , country
 , temp_06
 , precip_06
 FROM climate
 WHERE region = 'Africa'
)

SELECT DISTINCT cte.country
 , cte.temp_06
 , cte.precip_06
FROM athletes_wint AS wint
INNER JOIN countries_cte AS cte
 ON wint.country_code = cte.olympic_cc
ORDER BY temp_06;
