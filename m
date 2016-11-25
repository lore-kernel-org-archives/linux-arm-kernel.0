From: mzoran@crowfest.net (Michael Zoran)
Date: Thu, 24 Nov 2016 18:31:38 -0800
Subject: RPI3 doesn't boot in ARM64 mode on linux-next
Message-ID: <1480041098.1504.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last night I did a build of linux-next and I'm finding that I can no
longer get my RPI 3 to boot in arm64 mode anymore.  It seems to be
hanging very early in the boot process.  

I know linux-next is going through a very large number of changes now,
so does anybody know if arm64(not just the RPI 3) is just broken in
general at this point? 4.9rc6 is working fine.

I don't have a JTAG debugger, so it's a bit hard for me to debug.  I've
actually been looking for a decent cheap JTAG debugger for awhile now,
so if anybody knows of one in the < $300.00 range it might be a good
self Christmas present.
