# 作成手順

1. Dockerfile, docker-compose.yml,Gemfileの作成

- 初期のGemfile(railsアプリの作成で更新される)
```
source 'https://rubygems.org'

gem 'rails', '~> 6.1.4'
```

2. railsアプリの作成(MySQLの場合)

```
$ docker-compose run web rails new . --force --database=mysql
```

3. イメージの作成

```
$ docker-compose build
```

4. ./config/database.ymlの変更

```diff 
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
+  host: db
+  username: root
+  password: password
```

5. データベースの作成

```
$ docker-compose run web rails db:create
```

6. dockerの起動

```
$ docker-compose up -d
```

7. dockerの停止

```
$ docker-compose down
```

## Dockerコマンド

```
// rails cを行う
$ docker exec -it Dockerコンテナ名 bash
> bundle exec rails c

// rails db:migrate
$ docker-compose run web rails db:migrate

// log
$ docker-compose logs -f
```

## 開発環境を配る(clone)

```
$ docker-compose build
$ docker-compose run web bundle exec rake db:setup
$ docker-compose up
```

## Dockerでherokuへのデプロイの参考

https://zenn.dev/tama8021/scraps/7119380d7fb456

## railsコマンド

```
$ rails g controller Users new
  create  app/controllers/users_controller.rb
    route  get 'users/new'
  invoke  erb
  create    app/views/users
  create    app/views/users/new.html.erb
  invoke  test_unit
  create    test/controllers/users_controller_test.rb
  invoke  helper
  create    app/helpers/users_helper.rb
  invoke    test_unit
  invoke  assets
  invoke    coffee
  create      app/assets/javascripts/users.coffee
  invoke    scss
  create      app/assets/stylesheets/users.scss
```

```
$ rails g model User name:string email:string
  invoke  active_record
  create    db/migrate/20160523010738_create_users.rb
  create    app/models/user.rb
  invoke    test_unit
  create      test/models/user_test.rb
  create      test/fixtures/users.yml
```
