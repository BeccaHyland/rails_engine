## Rails Engine: Documentation

#### Rails Engine is a Ruby on Rails API for e-commerce data. For all merchants in the database, you can query the API and receive data on:

* All merchants
* Any one particular merchant
* Any particular group of merchants
* At random, one merchant
* All items belonging to a particular merchant's store
* The top merchants by total revenue earned, customize the number you want to be returned

#### Ruby version `2.4.2`Rails version `5.2.1`

After cloning down this repo, `bundle` the Gemfile and rails `db:{create,migrate}`

To seed the database, run `rake import:all`

To make API requests, boot up a local server with `rails s`, then in your browser try one of the following:

**All merchants' data:

`/api/v1/merchants`


**Search for one particular merchant by name, id, time created at, or time last updated at:

`/api/v1/merchants/find?name=enter merchant name here`

`/api/v1/merchants/find?id=enter merchant's id here`

`/api/v1/merchants/find?created_at=enter merchant's time created at here in the format 2018-09-09 00:00:00`


Use the above options to find multiple merchants by changing `find?` to `find_all?`


**All items belonging to particular merchant's store:

`/api/v1/merchants/enter a merchant id here/items`

**The Top merchants by revenue earned:

`/api/v1/merchants/most_revenue?quantity=enter a number here of how many merchants to be returned`

This query will return the highest merchant first, and so on (descending order).


To run the test suit, from the terminal enter `rspec`
