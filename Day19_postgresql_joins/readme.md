 Today I was walking through joins and found Using() function that helps in reducing the redundant common column obtained from joining multiple tables (ofcourse if we don't mention the column in select statement, which is another way most commonly used). Here is my notes from the chapter for some detailed understanding.

1.  Joining tables is often done by inner join with a common column and the column is derived from both the tables so we have one table with the same column repeating twice from each table. 
2.  Inner joins link two tables using a common column, returning only records that exist in both tables. The syntax is as follows:
Select *
From table1
Inner join table2
Using (column-name)
3.  Left joins return all records from the left table and matched records from the right table. If no match is found, the result is NULL from the right side. Similar to left joins, but return all records from the right table and matched records from the left table.
4.  The FULL OUTER JOIN returns all records from both tables. full outer joins return all records when there is a match in either left or right table, potentially slowing down query execution. For Left, right, outer and inner join we use a common column to join them.
5.  You can’t use aggregate functions in group by clause (the aggregate functions used for stats in select clause)
