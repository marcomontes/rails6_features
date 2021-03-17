# RUBY ON RAILS 6 FEATURES

## Installation

```
rbenv install 3.0.0
rbenv global 3.0.0
ruby -v  #3.0.0

gem install rails -v 6.1.1

rails new multidb_project
```


#### 1. ACTION MAILBOX


#### 2. ACTION TEXT


#### 3. MULTIPLE DATABASE SUPPORT

https://guides.rubyonrails.org/active_record_multiple_databases.html
*Rails 6 has launched support for multiple primary databases, which is very useful for applications seeking to scale horizontally rather just vertically*

#### 3.1 Setting up databases (database.yml)
```
development:
  primary:
    database: my_primary_database
    user: root
    adapter: sqlite3
  primary_replica:
    database: my_primary_database
    user: root_readonly
    adapter: sqlite3
    replica: true
  animals:
    database: my_animals_database
    user: animals_root
    adapter: sqlite3
    migrations_paths: db/animals_migrate
  animals_replica:
    database: my_animals_database
    user: animals_readonly
    adapter: sqlite3
    replica: true
```

#### 3.2 Generate Migrations

```
rails generate migration CreatePersons name:string
rails db:migrate:primary

rails generate migration CreateDogs name:string --database animals
rails db:migrate:animals

rails g migration add_person_to_dogs --database animals
rails db:migrate:animals
```

#### 3.3 Create Classes

```
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: { writing: :primary, reading: :primary_replica }
end

class AnimalsRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { writing: :animals, reading: :animals_replica }
end

class Person < ApplicationRecord
  has_many :dogs
end

class Dog < AnimalsRecord
  belongs_to :person
end
```

#### 3.4 Activating automatic connection switching (application.rb)

POST, PUT, DELETE, or PATCH request -> writer database. 
For the specified time after the write, the application will read from the primary.
GET or HEAD request -> read from the replica unless there was a recent write.

```
config.active_record.database_selector = { delay: 2.seconds }
config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
```

#### 3.5
```
Person.joins(:dogs)
Person.includes(:dogs)
```

#### 4. RUN TESTS CASES IN PARALLEL

#### 5. MORE ♥ FOR JAVASCRIPT

#### 6. ZEITWERK
---


Pendings
* manual connection switching
* Horizontal sharding
* Granular Database Connection Switching
* Use docker-compose to test different database engines - Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

https://docs.docker.com/compose/install/ 