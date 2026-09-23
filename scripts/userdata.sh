#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to the test of Self-Healing infrastructure</h1>"<p>My IP: "`curl -s http://checkip.amazonaws.com`"</p> > /var/www/html/index.html


