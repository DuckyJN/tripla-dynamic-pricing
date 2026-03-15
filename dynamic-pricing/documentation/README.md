# Development Documentation

## First impressions

Having a read through the background and the requirements of the take-home assignment, my first thought was to save the rate returned from the rate-api into the database with an expiry timestamp. And for each day, there are at least 10,000 requests, so having it fetch from the database and checking whether the most recent request is within 5 minutes of the last call, you would be able to determine if a new rate is needed.

However, as I was reading through the codebase, there is no rails database, so I am torn between two choices.

- One is to create a database that saves the parameters and rate that was returned.

- Two is to enable caching so that it only stays within memory for the 5 minutes.

## Implementations

1. Caching: The first thing that I am implemented is 5-minute caching for the rate. Took me a while to figure out how to get caching to work on the development environment, but executing `rails dev:cache` into the docker container, I was able to enable caching. However, after some testing, I have noticed that if I get an error or a null, it also gets cached for those 5 minutes. So I would have to add an error message for the user to retry fetching the rate to get a new one. However, since the error/null rate will be cached for the next 5 minutes, I would need to check if the cached result is an error/null, and if it is, rerun the fetch rate method.

2. Testing: Added a test case where it checks if the method properly caches the result instead of returning a different rate. In order to implement this, I turned on caching in the testing environment. However, the error/null checks have yet to be implemented.

3. Implemented a check and test on whether the cached result is null. If the result is null, the cached result gets cleared and asks the user to retry in order to retrieve the rate. For the test case, it is similar to the "should return error when rate API fails" case, but if the result still gets returned, then the service performs one more check. The next thing that needs to be implemented are the throughput requirements of at least 10,000 requests per day (There are 288 5-minute intervals in a day).

4. After having another look through the requirements, I forgot to implement caching for the different combinations of period/hotel/room, so the result would only be 1 rate for each combination of rooms. Therefore, I implemented caching for the different combinations. However, it occurred to me that having a database alongside the caching would help having redundancy and provide a history for each of the rates. This could allow for a future feature to graph the rate fluctuations over time in order for users to best anticipate the best rate for their buck.
