Today I revisited the data manipulation with pandas and did inspection on a DataFrame using various methods:

1) .head() returns the first few rows of the DataFrame.
2) .info() shows information on each of the columns, such as the data type and number of missing values.
3) .shape returns the number of rows and columns of the DataFrame.
4) .describe() calculates a few summary statistics for each column.

DataFrame consists of 3 attributes (not mthods):
1) .values: A two-dimensional NumPy array of values.
2) .columns: An index of columns: the column names.
3) .index: An index for the rows: either row numbers or row names.

sorting values and subsetting seems to be small things yet plays a major role in data manipulation.
