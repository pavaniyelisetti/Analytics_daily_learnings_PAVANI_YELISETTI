Hey everyone,

Today I have invested some time in learning Temporary tables, views and analyze function from DataCamp and here is my notes:
Using temporary tables is another option and one that can speed performance like subqueries and CTE (that we learnt yesterday).

TEMPERORARY TABLES:
1. They are short-lived storage. 
2. They are created similar to any table, using the CREATE TABLE command with the TEMP qualifier. 
 Ex: CREATE TEMP TABLE name As
3. They are available for the duration of the database session, meaning they only temporarily tie database resources. Within your database session, they are available in multiple distinct queries.
4. Contrast this with a CTE or subquery which is only available for that one query.
5. Temp tables are user specific, meaning they are available only to you as the creator. Creating a temporary copy of a slow table is a good way to make it faster to query.

VIEWS:
1. Views are similar to tables, with one key difference. Tables contain data. The data materialized and available. Views contain the directions to data. 
2. Sometimes base table slowness is because the table is actually a view, since this is also a temporary table.
3. Referencing the same table multiple times is inefficient and slow. Instead, you can create a temp table of the common, large table. The table is stored in memory and available as a faster copy in subsequent CTEs joined to this one table. 

ANALYZE:
1. ANALYZE returns no visible output but helps with the query execution plan.
2. ANALYZE calculates the records returned at different query points.
3. It stores this information in the pg_statistics (PostgreSQL system catalog) catalog. The query planner uses pg_statistics to estimate the runtime of the possible execution plans. The table statistics improve the query planner's ability to choose the optimal execution plan.
Ex: create temp table countries as
 SELECT DISTINCT o.region, a.country_code, o.country
 FROM athletes a
 INNER JOIN oregions o
 ON a.country_code = o.olympic_cc;
 
analyze countries; -> Collect the statistics

-> Count the entries
SELECT count(*) FROM countries;
