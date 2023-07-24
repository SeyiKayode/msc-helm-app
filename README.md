# msc-helm-app

# Creating the Microservice application
- create folder named "msc-helm-app" and enter the folder directory
- install nodejs
- create a nodejs app with npm init
- npm install express
- created app.js file to handle the app rendering using port 8080
- created a folder named "views" which contains the html and css files

# Create Dockerfile to build app
- create Dockerfile
- add docker configurations into the file
- the file pulls node library from aws public ecr because of dockerhub rate limit as we will be pushing our image into aws ecr
- it also expose port 8080

# Create AWS ECR and AWS EKS IaC to create our docker repository and kubernetes cluster
- inside the "resources-configuration/ecr_eks_template/ecr_eks_template.yaml" file, it contains the cloudformation template script that creates aws ecr and aws eks
- The cloudformation template creates various service roles, security groups, control planes, public and private subnets, vpc, epi, nat-gateway, internet-gateway and route tables

- there are 2 methods to create the cloudformation template

- 1st Method -->
- to create these resources using the aws cli, configure your aws user profile with the command "aws configure --profile $YOUR_NAME"
- $YOUR_NAME is the name you want to use to configure your aws cli profile 
- create a file named "resources-configuration/ecr_eks_template/ecr_eks_template.json" and write the environment parameters in it (i gitignored my json parameter file but check the sample_parameter.json to see how it looks like and fill the ParameterValue), cd into this directory "resources-configuration/ecr_eks_template/", run "chmod +x ecr_eks_template.sh", inside the "ecr_eks_template.sh" file change "export AWS_PROFILE=kayode" into "export AWS_PROFILE=$YOUR_NAME" then run "./ecr_eks_template.sh"

- 2nd Method -->
- to create these resources using the aws console, go to cloudformation and use the "resources-configuration/ecr_eks_template/ecr_eks_template.yaml" file to create a cloudformation stack and supply the environment parameters
- the resources will be created and ready for use

# Create helm chart for microservice application
- install helm
- create helm chart using the command "helm create msc-helm-chart". This will create a chart with folder named "msc-helm-chart" which contains the helm configuration files
- change the image repository in "msc-helm-chart/values.yaml" file to the aws ecr repository uri that we created using aws ecr in our cloudformation template.
- inside the same "msc-helm-chart/values.yaml" file, change service type to "LoadBalancer", change service port to "8080", add service targetPort with value "8080", add service name with value "node-app-service", change replicaCount to 1 since it's for test
- inside "msc-helm-chart/templates/deployment.yaml", change ports containerPort to "8080"

# Create AWS Codepipeline IaC to run the CI/CD deployment
- after the aws ecr and aws eks cloudformation template has finsihed creating i.e "CREATE_COMPLETE" status, we proceed to create our CI/CD pipeline
- inside the "resources-configuration/codepipeline_template/codepipeline_template.yaml" file, it contains the cloudformation template script that creates aws codebuild and codepipeline to begin our CI/CD process
- The cloudformation template creates various service roles, codebuild and codepipeline resources
- it makes use of "buildspec_prepare.yaml" and "buildspec_deploy.yaml" to run the installations of needed packages, connecting to our previously created eks cluster and packaging of the helm chart in the codepipeline

- 1st Method -->
- to create this pipeline using the aws cli, we set our aws cli user profile that was configured earlier by modifying the "codepipeline_template.sh" file and change "export AWS_PROFILE=kayode" into "export AWS_PROFILE=$YOUR_NAME", create a file named "resources-configuration/codepipeline_template/codepipeline_template.json" and write the environment parameters in it (i gitignored my json parameter file but check the sample_parameter.json to see how it looks like and fill the ParameterValue), cd into this directory "resources-configuration/codepipeline_template/", run "chmod +x codepipeline_template.sh", then run "./codepipeline_template.sh"

- 2nd Method -->
- to create this pipeline using the aws console, go to cloudformation and use the "resources-configuration/codepipeline_template/codepipeline_template.yaml" file to create a cloudformation stack and supply the environment parameters
- the resources will be created and it will also begin the CI/CD process

# Post Deployment
- After the codepipeline is done with the CI/CD process, go to the ec2 console and check load balancers
- the load balancer is already created, copy the url and append ":8080/" to the end
- paste the url to your browser and it will display the nodejs application
- now we are able to manage our IaC resources such as eks, ecr and the codepipeline using cloudformation templates
