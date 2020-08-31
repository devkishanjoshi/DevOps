resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  kafka-ip = aws_instance.kafka.*.private_ip,
  zookeeper-ip = aws_instance.zookeeper.*.private_ip
  zk-tools-ip = aws_instance.zk-tools.*.private_ip
 }
 )
 filename = "inventory"
}



