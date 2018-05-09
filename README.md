# Weather App CloudFormation Demo

Assumptions:
- This template is used in us-east-1.  If it is used in a different region, it has to be updated accordingly, including the AMI that is referenced for the EC2 instance.
- There is a key pair titled "virginia" in the region where the teplate is used.
- A cronjob is used to send out the mailings.  This is (badly) running as root and is configured to run at midnight (server-time) daily.

What can be done better (this will be a long list, not necessarily in any order):
- A single web server instance should be replaced with at least three spread across different AZs in an auto-scale group where, paired with an ELB, unhealthy instances can be terminated and replaced with healthy ones automatically.  In combination with CloudWatch Health Checks (based on CPU, etc.), proper scaling up and down based on load can be accomplished.
- The database should be moved to RDS rather than being run locally.
- The API key for Weather Underground should be stored in Parameter Stored and requested at EC2 instance launch.  In fact a lot of data in the template should be parameterized.
- Should script the creation of the admin user.  Currently you need to log in to the EC2 instance after provisioning to run the command.
- In order to support auto-scaling, the provisioning that is currently being performed in UserData should be moved to a Launch Configuration.
- Any external depenendies (i.e. nginx.conf) should be stored in an S3 bucket and during provisioning should be accessed using an IAM role that has access, instead of being stored in GitHub.
- In the application, DEBUG = True, ALLOWED_HOSTS properly defined, and a new randomly generated value should be used for SECRET_KEY (I need to brush up on my sed / awk skills).
- The classic ELB used should be replaced with an ELB with TLS termination where the certificate is stored in ACM.  Also, the health checks should validate application functionality and not simply call "/".
- The load balanced resources (i.e. web servers) should be configured for an internal (behind NAT GW) subnet rather than have an individual public IP address. (This should be easy to fix in this example template.)
- All parameter inputs (i.e. IP address / subnet for SSH access) should be validated.  Parameters should also be used to further "genericize" the template so that it can be deployed in any region without manually updating the code itself.  This includes retrieving a list of regions, availability zones, Amazon Linux AMI IDs, etc. and presenting them as options instead of free-form input.
- The application's email functionality should be updated so that it sends from a valid "From:" email address and uses a third-party service for relay (i.e. SES) instead of sending directly from the EC2 instance as it will almost certainly go to spam.
- The applications (i.e. nginx, Python-based web server) should be configured to run as unprivileged users (i.e. not root, but instead something like www-data).
- Log files should be shipped to an external provider (syslog, ELK stack, etc.).
- CloudWatch (or other equivalent) monitoring should be configured for CPU, disk latency, etc.  Custom Metrics should be used to measure health inside the instance (i.e. free memory, free disk space, etc.).

With additional time these can all be accomplished.
