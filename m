From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 3 Jul 2012 22:10:07 -0300
Subject: MX28 poweroff issue
In-Reply-To: <201207040030.36713.marex@denx.de>
References: <201207040030.36713.marex@denx.de>
Message-ID: <CAOMZO5AEG5g9EYP558UWtX2m-HicAng=h008raN8wA0Yqy-xdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Jul 3, 2012 at 7:30 PM, Marek Vasut <marex@denx.de> wrote:
> Hello,
>
> I recently confirmed this issue when doing "poweroff". The issue was initially
> reported by Detlev Zundel.
>
> The console output (trimmed) can be seen below:

Is this an ARM926EJS issue?

Just tried it on a mx31 and I don't get such issue:

root at freescale /$ poweroff
starting pid 723, tty '': '/etc/rc.d/rcS stop'
Stopping inetd:
Terminated
Unmounting filesystems
umount: tmpfs busy - remounted read-only
umount: devtmpfs busy - remounted read-only
chown: /home/user/.rhosts: Read-only file system
chown: /home/user: Read-only file system
chown: /home/user: Read-only file system
cat: can't open '/proc/devices': No such file or directory
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
System halted.

Regards,

Fabio Estevam
