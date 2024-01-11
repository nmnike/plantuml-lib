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

[tupadr3-complex](https://raw.githubusercontent.com/nmnike/plantuml-lib/master/examples/tupadr3-complex.puml)

![UML](https://www.plantuml.com/plantuml/svg/5Oqx3i8m341tJW47Q3omCVKgRcBH2CUn_14zFcHwUiFJsptG8WVV7bqgPwCqlfyHwYy0mszvzpZpI2UhKu8aIfq3P4Z_42YZh7hZVi103pAW2uSoEKGgDdjkTIw_YgxDJjB-_040)

[v8.puml](https://raw.githubusercontent.com/nmnike/plantuml-lib/master/examples/v8.puml)

![UML](https://www.plantuml.com/plantuml/svg/5Smz4i90243XtbFe0LnQnofN8Hl6x0Y4uKSzljdgLUzR8j6pX2-tePrhetA-xfaMJm37RtkDt6kj8E-79ccsVWYew7WJ6AFE-yvZ1S58Sg0VYZ45V1xDfhoGRcV_)


### Include UML Diagrams in Github using PlantUML
1. Create a .puml file, for this gist I'm creating a file below named testuml.puml

2. Open (Plantuml.com)[http://plantuml.com/plantuml/form] to edit a new .puml document 

3. Use the `!includeurl` and provide the URL of your .puml file stored in github (RAW)

```
@startuml
!includeurl https://raw.githubusercontent.com/nmnike/plantuml-lib/master/examples/tupadr3-complex.puml
@enduml
```

4. Obtain the generated URL in the plantuml server form and use markdown to include an image from an url 

5. Change the `/png/` to `/svg/` to obtain the svg format of the UML diagram.

```markdown
![UML](https://www.plantuml.com/plantuml/svg/5Oqx3i8m341tJW47Q3omCVKgRcBH2CUn_14zFcHwUiFJsptG8WVV7bqgPwCqlfyHwYy0mszvzpZpI2UhKu8aIfq3P4Z_42YZh7hZVi103pAW2uSoEKGgDdjkTIw_YgxDJjB-_040)
```
