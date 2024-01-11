# Набор спрайтов и макросов для использования в диаграммах PlantUML

## Начало работы

Обратите внимание, что работать с этой библиотекой можно либо локально, либо через интернет.

### Локально

Работа локально позволяет не зависеть от интернета и вносить изменения в библиотеку самостоятельно.

- клонировать репозиторий
- в начале _вашего_ puml-файла добавить директивы импорта

```puml
!include ../v8/common.puml
!include ../v8/all.puml
и т.д.
```

> При работе локально вместо подключения нескольких отдельных файлов с префиксом `v8_` можно подключить единственный файл `all_local.puml`

### Через интернет

- в начале _вашего_ puml-файла добавить директивы импорта:

```puml
!define v8 https://raw.githubusercontent.com/nmnike/plantuml-lib/master/v8
!include v8/common.puml
!include v8/v8_Catalog.puml
!include v8/v8_Document.puml

или

!define tupadr3 https://raw.githubusercontent.com/nmnike/plantuml-lib/master/tupadr3

!include tupadr3/common.puml
!include tupadr3/font-awesome-5/server.puml
!include tupadr3/font-awesome-5/gitlab.puml

```

> ВНИМАНИЕ! При работе через интернет необходимо подключать каждый файл отдельно.


### Примеры

Примеры использования находятся в каталоге examples

```puml
@startuml

skinparam defaultTextAlignment center

!define tupadr3 https://raw.githubusercontent.com/nmnike/plantuml-lib/master/tupadr3

!include tupadr3/common.puml
!include tupadr3/font-awesome-5/server.puml
!include tupadr3/font-awesome-5/gitlab.puml
!include tupadr3/font-awesome/gears.puml
!include tupadr3/font-awesome/fire.puml
!include tupadr3/font-awesome/clock_o.puml
!include tupadr3/font-awesome/lock.puml
!include tupadr3/font-awesome/cloud.puml

!include tupadr3/devicons/nginx.puml
!include tupadr3/devicons/mysql.puml
!include tupadr3/devicons/redis.puml
!include tupadr3/devicons/docker.puml
!include tupadr3/devicons/linux.puml

FA_CLOUD(internet,internet,cloud) {
}

DEV_LINUX(debian,Linux,node){

	FA_CLOCK_O(crond,crond) #White
	FA_FIRE(iptables,iptables) #White

	DEV_DOCKER(docker,docker,node) #LightBlue {
		DEV_NGINX(nginx,nginx,node) #White
		DEV_MYSQL(mysql,mysql,node) #White
		DEV_REDIS(redis,redis,node) #White
		FA5_SERVER(nexus,nexus3,node) #White
		FA5_GITLAB(gitlab,gitlab,node) #White
		FA_GEARS(gitlabci,gitlab-ci-runner,node) #White

		FA_LOCK(letsencrypt,letsencrypt-client,node) #White
	}
}

internet ..> iptables : http

iptables ..> nginx : http
nginx ..> nexus : http
nginx ..> gitlab : http
gitlabci ..> gitlab : http
gitlab ..> mysql : tcp/ip
gitlab ..> redis : tcp/ip

crond --> letsencrypt : starts every month

@enduml
```