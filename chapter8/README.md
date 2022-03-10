# chapter 8: How to Use Terraform as a Team

Costs of adopting IaC
- Skills gap
- New tools
- Change in mindset
- Opportunity cost

Work incrementally. Take small things to do with IaC so it can grow. Make it to big and it will fail. 

Deployment strategies
- Rolling deployment with replacement
- Rolling deployment without replacement
- Blue-green deployment
- Canary deployment

Deploying infrastructure as Code
1. Use version control.
2. Run the code locally.
3. Make code changes.
4. Submit changes for review.
5. Run automated tests.
6. Merge and release.
7. Deploy.

## The Golden Rule of Terraform:
The master branch of the live repository should be a 1:1 representation of what’s actually deployed in production.

# Terragrunt

Terragrunt is an opensource tool around terraform that makes it more simple to use different environments and configurations without copy/paste the code to several environments

Terragrunt link:
https://github.com/gruntwork-io/terragrunt