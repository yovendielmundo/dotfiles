# APPLICATION NAME
*short slogan, deep meaning phrase, or funny fact about the project* 😀

## 👨🏻‍💻 About the project

Brief explanation about the project.  
This application is consuming these events...  
Provide a public/private API...  
Persist in the DB these entities...  
Publish these events... 


## 🚀 Technologies

Relevant technologies used to develop this project

- [Scala](https://scala-lang.org/)
- [Springboot](https://spring.io/guides/gs/spring-boot/)
- [TestContainers](https://www.testcontainers.org/)
- [CatsEffect](https://typelevel.org/cats-effect/)
- [Liquibase](https://www.liquibase.org/)
- [ReactJS](https://reactjs.org/)
- [TypeScript](https://www.typescriptlang.org/)
- [React Router DOM](https://reacttraining.com/react-router/)
- [Commitizen](https://github.com/commitizen/cz-cli)
- [Eslint](https://eslint.org/)

## 💻 Getting started

### 🛠 Dependencies

**Infrastructure**
- MongoDB
- RabbitMQ
- Consul
- Consul-template
- Docker
- ...

**Applications**
- Locations
- Mailer
- ...

**External**
- Braintree
- ERP
- Google Cloud Storage
- ...


### 🤔 How to develop

#### Git flow
> Please remember to create a fork of the repository

```bash
# Fork using GitHub official command line
# If you don't have the GitHub CLI, use the web site to do that.

$ gh repo fork packlink-dev/$REPOSITORY_NAME
```


```bash
# Clone your fork
$ git clone $MY_FORK_URL && cd $REPOSITORY_NAME

# Create a branch with your $FEATURE (feature/task)
$ git checkout -b $FEATURE

# Make the commit with your changes
$ git commit -m "$FEATURE My new feature"

# Send the code to your remote branch
$ git push origin $FEATURE
```

#### Testing
> Note that, thanks to test-containers, you don't need any infrastructure component to run integration test on your local environment

```shell
# Command to run the unit tests (ie: sbt)
$ ./sbt test

# Command to run the integration tests (ie: sbt)
$ ./sbt it:test
``` 

#### Building 
```shell
# Command to build the application (ie: sbt) 
$ ./sbt stage 
```

#### Running
```shell
# Command to run the application (ie: sbt)
$ ./sbt run
```
> Remember that you'll need to populate the configuration:
```shell
# Command to populate the configuration (ie: consul-template)
consul-template -consul consul.service.consul:8500 -template "./application.yml.ctmpl:./application.yml" -once
```

## 📝 License / Owners

This project under MIT License - see the [LICENSE](LICENSE) file for details.
- [Agent Smith](agent-smith@matrix.com)

---
