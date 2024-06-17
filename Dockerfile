# Build this container to run in AWS Batch
 
# Start with the latest AWS-CLI v2 image
FROM public.ecr.aws/aws-cli/aws-cli:latest
# Consider using "--platform=linux/amd64" if building on Apple Silicon
 
# Install additional software as needed
RUN yum update -y && yum install -y wget unzip

WORKDIR /tmp
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.20.4/2021-04-12/bin/linux/amd64/kubectl
RUN chmod 755 ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN kubectl version --short --client
 
# Copy your project code into the container
RUN yum install -y jq 
COPY scoring.sh /


# Default execution
ENTRYPOINT ["/bin/bash","/scoring.sh"]
 
# Default parameters
CMD ["aws"]
