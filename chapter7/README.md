# Chapter 7

# Summary
Clean up developers work with tools like

- Cloud-nuke
- Janitor Monkey -> replaced by swabbie
- aws-nuke

3 kinds of tests
1. unit tests
just a single small unit of code testing

You cannot do pure unit testing for Terraform code. They are more integration tests. But we call testing a single module a unit test

2. Integration tests
verify that multiple units work together correctly

3. End-to-end tests
Test your entire architecture in a different environment to test the changes


Things to remember
- When testing Terraform code, there is no localhost
- Regularly clean up your sandbox environments
- You cannot do pure unit testing for Terraform code
- You must namespace all of your resources
- Smaller modules are easier and faster to test


# Testing with terratest

Use the vagrant box with go installed
```
export PATH=/home/vagrant/go/bin/:$PATH
```
run the test
```
go test -v -timeout 30m
```

When running the alb_examepl_test.go you should see the following output
```
TestAlbExample 2022-03-01T14:59:02Z command.go:121: Destroy complete! Resources: 5 destroyed.
--- PASS: TestAlbExample (222.89s)
PASS
ok      terraform-up-and-running        222.891s
```

Run a specific test
```
go test -v -timeout 30m -run TestHelloWorldAppExample
```

result
```
TestHelloWorldAppExample 2022-03-05T14:58:46Z command.go:121: Destroy complete! Resources: 13 destroyed.
--- PASS: TestHelloWorldAppExample (279.40s)
PASS
ok      terraform-up-and-running        279.407s
```

To run multiple tests in parallel make sure the following is in the go scripts
```
	t.Parallel()
```


run just the database part
```
SKIP_deploy_app=true \
SKIP_validate_app=true \
SKIP_teardown_app=true \
SKIP_redeploy_app=true \
go test -timeout 30m -run 'TestHelloWorldAppStageWithStages'
```

```
vagrant@terraform-up-and-running:~/go/src/terraform-up-and-running$ go test -timeout 30m -run 'TestHelloWorldAppStageWithStages'

PASS
ok      terraform-up-and-running        1416.001s
```

# Vagrant usage

For terratest to work properly with the exercises following things need to be done

install correct dep version
```
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

export PATH=/home/vagrant/go/bin:$PATH
```

make sure terratest is version 0.15.9
```
dep ensure -add github.com/gruntwork-io/terratest/modules/terraform@v0.15.9
```

file Gppkg.toml need to be changed to include the following. Otherwise you will get blackfriday errors during the test run
```
[[override]]
  name = "github.com/russross/blackfriday"
  version = "1.5.2"
```  

