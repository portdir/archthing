#
en # enable
conf t # config terminal
no ip domain-lookup # on PT
no ip domain lookup # on lab

int f0/0/0 # set one type of interface

int range s0/?-?, f0/?-?, g0/?-? # to do range

copy running-config startup-config # save
Copy run start # also save

end # Returns to privileged EXEC mode.
exit #  go back a mode

banner motd $ good users can git in $ # do for all of them
copy startup-config running-config # go back a conf
reload # to reset a cisco thing without power off and on

