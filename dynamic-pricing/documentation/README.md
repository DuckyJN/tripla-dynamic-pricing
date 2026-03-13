# Development Documentation

## First impressions

Having a read through the background and the requirements of the take-home assignment, my first thought was to save the rate returned from the rate-api into the database with an expiry timestamp. And for each day, there are at least 10,000 requests, so having it fetch from the database and checking whether the most recent request is within 5 minutes of the last call, you would be able to determine if a new rate is needed.

However, as I was reading through the codebase, there is no rails database, so I am torn between two choices.

- One is to create a database that saves the parameters and rate that was returned.

- Two is to enable caching so that it only stays within memory for the 5 minutes.
