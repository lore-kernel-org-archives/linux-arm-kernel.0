From: alanbutty12@gmail.com (Alan M Butler)
Date: Sat, 18 Aug 2012 09:20:29 -0000
Subject: Issues with all kernels after 3.3.7
Message-ID: <CADhrpJ69K1Lg6MCNQvqt3d641d-X-jDRRO93QzVarE2aTp4_YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been experimenting with building the kernels under 3 seperate
virtual machines

ubuntu 11.10
ubuntu 12.04
ubuntu 12.10

and even when i recompile a new fresh 3.3.7 kernel im seeing the issue
with git hanging
or crashing the device.

Is there an official or best way to compile an arm debian kernel?
armv5te i believe it is

The 2 main ways i have tired to compile the kernel are found on the 2
following sites:

?http://blog.nobiscuit.com/2011/11/04/compiling-kernels-for-the-marvell-kirkwood-soc-under-ubuntu-11-10/

http://forum.doozan.com/read.php?2,6010,7629

but for some reason now even on a newly installed virtual machine i
have the issue's i mentioned before.

to restate them:

using git clone hang's / crashes the device.

hang at boot when mounting the ext4 .raid 0
