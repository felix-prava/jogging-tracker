# Jogging Tracker App

It is a Ruby on Rails app that allows users to create an account and insert jogging times. There are 3 types uf users:

-normal user: can add jogging times and see a weekly report of the inserted times

-manager: can CRUD users

-admin: can CRUD users and all records

![image](https://user-images.githubusercontent.com/62405899/107881038-f2cf3300-6eea-11eb-8ffd-9567451f04f7.png)

Each time entry when entered has a date, distance, and time.

![image](https://user-images.githubusercontent.com/62405899/107880926-7a687200-6eea-11eb-80b4-636818027959.png)

When displayed, each time entry has average speed.

![image](https://user-images.githubusercontent.com/62405899/107880957-a683f300-6eea-11eb-8173-db1c7b516b17.png)

Filter by dates from-to.
Report on average speed & distance per week.

![image](https://user-images.githubusercontent.com/62405899/107881002-dcc17280-6eea-11eb-84fd-b6a4f6ba4ea3.png)

The password is hashed. Every page has access control so only logged in users can do specific actions.
All actions are done without refreshing the page, using Ajax.

## Getting started
To get started with the app, clone the repo and then install the needed gems:
```
$ bundle install --without production
```
Next, migrate the database:
```
$ rails db:migrate
```
Finally, run the test suite to verify that everything is working correctly:
```
$ rails test
```
If the test suite passes, you'll be ready to run the app in a local server:
```
$ rails server
```

Login page with invalid password/email combination

![image](https://user-images.githubusercontent.com/62405899/107880785-c0710600-6ee9-11eb-8b55-7fbdb308f9fd.png)
