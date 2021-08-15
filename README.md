# 作成手順

1. Dockerfile, docker-compose.yml,Gemfileの作成

- 初期のGemfile(railsアプリの作成で更新される)
```
source 'https://rubygems.org'

gem 'rails', '~> 6.1.4'
```

2. railsアプリの作成

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