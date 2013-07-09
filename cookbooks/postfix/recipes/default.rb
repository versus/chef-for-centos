#
# postfix and dovecot
#

#
# Configuration files
#

package "dovecot" do
  action :install
  not_if "rpm -q dovecot"
end

package "postfix" do
  action :install
  not_if "rpm -q postfix"
end




