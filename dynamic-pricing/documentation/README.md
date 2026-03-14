# Development Documentation

## First impressions

Having a read through the background and the requirements of the take-home assignment, my first thought was to save the rate returned from the rate-api into the database with an expiry timestamp. And for each day, there are at least 10,000 requests, so having it fetch from the database and checking whether the most recent request is within 5 minutes of the last call, you would be able to determine if a new rate is needed.

However, as I was reading through the codebase, there is no rails database, so I am torn between two choices.

- One is to create a database that saves the parameters and rate that was returned.

- Two is to enable caching so that it only stays within memory for the 5 minutes.

## Implementations

1. Caching: The first thing that I am implemented is 5-minute caching for the rate. Took me a while to figure out how to get caching to work on the development environment, but executing `rails dev:cache` into the docker container, I was able to enable caching. However, after some testing, I have noticed that if I get an error or a null, it also gets cached for those 5 minutes. So I would have to add an error message for the user to retry fetching the rate to get a new one. However, since the error/null rate will be cached for the next 5 minutes, I would need to check if the cached result is an error/null, and if it is, rerun the fetch rate method.
