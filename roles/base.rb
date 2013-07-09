name "base"
description ""
run_list(
  "recipe[common]",
  "recipe[selinux]",
  "recipe[yum]",
  "recipe[iptables]",
  "recipe[httpd]",
  "recipe[php]",
  "recipe[mysql]",
  "recipe[vsftpd]",
  "recipe[varnish]",
  "recipe[postfix]"
)

default_attributes({
  :role                => "base",
})
