# Backend Engineering Take-Home Assignment: Dynamic Pricing Proxy

The Dynamic Pricing Proxy is a standalone api where a user can fetch hotel room rates from a ([rate api](https://hub.docker.com/r/tripladev/rate-api)). This application would allow clients to retrieve, albeit, arbitrary hotel room rates in order to plan their stay at a hotel of their choosing.

## Useful Documents

There are two main documents that have been prepared in order to help users follow what is going on. Under the documentation folder in `dynamic-pricing`, there are two files, ([Development_Documentation.md](dynamic-pricing/documentation/Development_Documentation.md)) and ([Test_Cases.md](dynamic-pricing/documentation/Test_Cases.md)).

In ([Development_Documentation.md](dynamic-pricing/documentation/Development_Documentation.md)), it outlines the development steps taken and the thought process on how I came to implement it.

In ([Test_Cases.md](dynamic-pricing/documentation/Test_Cases.md)), it outlines the different test cases within each file. It makes it easier to know what test cases were implemented in each file at a glance.

## Usage

### Required Applications

- Docker Desktop

### Common Commands

Here is a list of common commands for building, running, and interacting with the Dockerized environment.

```bash

# --- 1. Build & Run The Main Application ---
# Build and run the Docker compose
docker compose up -d --build

# --- 2. Test The Endpoint ---
# Send a sample request to your running service
curl 'http://localhost:3000/api/v1/pricing?period=Summer&hotel=FloatingPointResort&room=SingletonRoom'

# --- 3. Run Tests ---
# Run the full test suite
docker compose exec interview-dev ./bin/rails test

# Run a specific test file
docker compose exec interview-dev ./bin/rails test test/controllers/pricing_controller_test.rb

# Run a specific test by name
docker compose exec interview-dev ./bin/rails test test/controllers/pricing_controller_test.rb -n test_should_get_pricing_with_all_parameters
```
