output "sonar_dns" {
  value = "${aws_lb.jenkins-sonarqube-lb.dns_name}"
}

output "jenkins_dns" {
  value = "${aws_lb.jenkins-sonarqube-lb.dns_name}/Jenkins"
}