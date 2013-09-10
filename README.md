BestSellerMotion
================

RubyMotion iOS app for interacting with the NYTimes Best Seller's API

How to Use
==========

$ git clone
$ cd BestSeller
$ git log

In your log you'll see a series of commits, each one tagged.  Cycle through the tags using

$ git checkout <tag number>

to 'build' the app. 

Using .ruby-version ruby-2.0.0-p0 and .ruby-gemset bestsellermotion.  Run: 

$ rvm use ruby-2.0.0-p0
$ rvm gemset create bestsellermotion
$ cd ..
$ cd BestSeller

before bundling.

You'll need to create your own app.yml file in the resources directory with your NYTimes BestSeller's List API key
which you can find [here](http://developer.nytimes.com/docs/best_sellers_api/ "NYTimes").  Enter this key as a string 
value for API_KEY key in your app.yml.  For instructions on setting this up, see the motion-config-vars gem github at
https://github.com/jamescallmebrent/motion-config-vars.

Enjoy!
