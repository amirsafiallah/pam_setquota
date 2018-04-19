PAM `setquota` module
=====================

This module sets (or modifies) a disk quota when a session begins.

This makes quotas usable with central user databases, such as MySql or LDAP.

Usage
-----
A single invocation of `pam_setquota` applies a specific policy to a UID and GID range.
Applying different policies to specific UID and GID ranges is done by invoking
`pam_setquota` more than once.

Some parameters can be passed to `pam_setquota.so` through the PAM config:
- `fs` is the device file or mountpoint the policy applies to.  
  Defaults to the filesystem containing the users home directory.
- `startuid` and `enduid` describe the UID range the policy is applied to.  
  Setting `enduid=0` results in an open-ended UID range (i.e. all uids greater
  than `startuid` are included).  
  Defaults to `startuid=1000` and `enduid=0`.
- `startgid` and `endgid` describe the GID range the policy is applied to.  
  Setting `endgid=0` results in an open-ended GID range (i.e. all gids greater
  than `startgid` are included).  
  Defaults to `startgid=1000` and `endgid=0`.
- `overwrite` lets you override an existing quota.  
  Note: Enabling this will remove the ability for the admin to manually configure
	different quotas for users for a filesystem with `edquota(8)`.
- `bsoftlimit`, `bhardlimit`, `isoftlimit` and `ihardlimit` are as defined by
  `quotactl(2)`:
  - `b` expresses a number of blocks (size limit), whereas
	`i` is a limit on the number of inodes.
  - `softlimit` is a threshold after which the user gets warnings,
	whereas `hard` limits cannot be exceeded.


Example
-------
One of the following lines can be used (/etc/pam.d/common-session on Ubuntu)

	session    required     /lib/security/pam_setquota.so bsoftlimit=19000 bhardlimit=20000 isoftlimit=3000 ihardlimit=4000 startuid=1000 enduid=2000 fs=/dev/sda1
	session    required     /lib/security/pam_setquota.so bsoftlimit=1000 bhardlimit=2000 isoftlimit=1000 ihardlimit=2000 startuid=2001 enduid=0 fs=/home
	session    required     /lib/security/pam_setquota.so bsoftlimit=19000 bhardlimit=20000 isoftlimit=3000 ihardlimit=4000 startuid=1000 enduid=2000 fs=/dev/sda1 overwrite=1
	session    required     /lib/security/pam_setquota.so bsoftlimit=19000 bhardlimit=20000 isoftlimit=3000 ihardlimit=4000 startuid=1000 enduid=2000 fs=/dev/sda1 overwrite=1 debug=1
	session    required     /lib/security/pam_setquota.so bsoftlimit=19000 bhardlimit=20000 isoftlimit=3000 ihardlimit=4000 startgid=5 endgid=10 startuid=1000 enduid=2000 fs=/

Useful resources
-------------------
How to set quota through c API
- http://souptonuts.sourceforge.net/quota_tutorial.html

The Linux-PAM Module Writers' Guide
http://www.linux-pam.org/Linux-PAM-html/Linux-PAM_MWG.html

Modification
-------------------
- `startgid` and `endgid` are added.
- `endmntent` function should be call at the end of `getmntent`


Licence and credits
-------------------
All licences and credits are explained on
- https://github.com/shartge/pam_setquota
