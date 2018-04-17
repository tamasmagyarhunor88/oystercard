# Oystercard Challenge
Oystercard is a week 2 challenge at Makers Academy to strech our existing Ruby, TDD and object oriented design skills

## Features
  - User has an oystercard with a minimum balance
  - User can add money to oystercard
  - User has a maximum balance 90£ limit on card
  - User has fare deducted from its card
  - User can touch in and out
  - User is charged minimum fare for a single journey
  - User only pais for journey when it's complete
  - User is charged penalty fare if didn't touch in or didn't touch out

## Technologies used
  - Ruby
  - RSpec 

## How to install
Make sure you have Ruby and Bundler installed

````
$ git clone https://github.com/tamasmagyarhunor88/oystercard.git
$ cd oystercard
$ bundle install
````

## Running tests
In the project directory

````
rspec                       <- runs all the tests
rspec spec/file_name.rb     <- runs specific test file
````


## User stories:

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
