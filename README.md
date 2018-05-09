# Weather App CloudFormation Demo

Assumptions:
- This template is used in us-east-1.  If it is used in a different region, it has to be updated accordingly, including the AMI that is referenced for the EC2 instance.
- There is a key pair titled "virginia" in the region where the teplate is used.

What can be done better (this will be a long list not necessarily in order):
- A single web server instance should be replaced with at least three spread across different AZs.
- The database should be moved to RDS.
- The API key for Weather Underground should be stored in Parameter Stored and requested at EC2 instance launch.
- In order to support autoscaling, the provisioning that is currently being performed in UserData should be moved to a Launch Configuration.
- Any external depenendies (i.e. nginx.conf) should be stored in an S3 bucket and during provisioning should be accessed using an IAM role that has access, instead of being stored in GitHub.
- In the application, DEBUG = True, ALLOWED_HOSTS properly defined, and a new randomly generated value should be used for SECRET_KEY.
- The classic ELB used should be replaced with an ELB with TLS termination where the certificate is stored in ACM.
- The load balanced resources (i.e. web servers) should be configured for an internal (behind NAT GW) subnet rather than have an individual public IP address. (This should be easy to fix in this example template.)
