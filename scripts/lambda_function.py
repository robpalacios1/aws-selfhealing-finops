import boto3
import logging

# basics settings of logs for CloudWatch
logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client("ec2")

def lambda_handler(event, context):
    # Filters instances to get only running instances
    filters = [
        {
            "Name": "instance-state-name",
            "Values": ["running"]
        },
        {
            "Name": "tag:AutoStop",
            "Values": ["true"]
        }
    ]
    """Lambda handler function"""

    try:
        instances = ec2.describe_instances(Filters=filters)
        instances_to_stop = []

        # Extract ID's of found instances
        for reservation in instances["Reservations"]:
            for instance in reservation["Instances"]:
                instances_to_stop.append(instance["InstanceId"])

        if instances_to_stop:
            logger.info(f"Stopped instances: {instances_to_stop}")
            ec2.stop_instances(InstanceIds=instances_to_stop)
            return f"FinOps Automation: {len(instances_to_stop)} instances stopped successfully"
        else:
            logger.info("FinOps Automation: No Instances Found To Stop")
            return "No Action Taken: No Resources Found To Stop"
       
        
    except Exception as e:
        logger.error(f"Error executing FinOps Automation: {str(e)}")
        raise e