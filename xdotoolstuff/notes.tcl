en
conf t
no ip domain-lookup

end
copy run start
########################
en
# enable
conf t
# config terminal
no ip domain-lookup
# on PT
no ip domain lookup
# on lab

int f0/0/0
# set one type of interface

int range s0/?-?, f0/?-?, g0/?-?
# to do range

copy running-config startup-config
# save
Copy run start
# save

end
# Returns to privileged EXEC mode.
exit
#  go back a mode

banner motd $ good users can git in $
# do for all of them
copy startup-config running-config
# go back a conf

# all the same
copy running-config startup-config
copy run start
write memory
wr
#
reload
# to reset a cisco thing without power off and on

