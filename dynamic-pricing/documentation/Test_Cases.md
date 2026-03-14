# Testing List

## Overview

This document is created in order to have an overarching view of all the test cases that are within each of the test documents.

## Files

### Controllers

#### pricing_controller_test.rb

- should get pricing with all parameters
- should return error when rate API fails
- should return error without any parameters
- should handle empty parameters
- should reject invalid period
- should reject invalid hotel
- should reject invalid room
- should get pricing through cache
