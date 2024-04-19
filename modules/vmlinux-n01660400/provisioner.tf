resource "null_resource" "display_hostnames" {
  count      = var.vm_count
  depends_on = [azurerm_linux_virtual_machine.vm-linux]
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "Japan"
      private_key = file("${var.vmlinux_priv_key_path}")
      host        = azurerm_public_ip.linux-ip[count.index].fqdn
    }
    inline = [
      "echo 'The hostname is:' $(hostname)"
    ]
  }
}