From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Tue, 19 Nov 2013 14:45:41 -0500
Subject: at91: ubi: UBIFS error (pid 1): ubifs_iget: failed to read inode 1,
 error -2
Message-ID: <91586D499ADFD74FBCFB8425266A5DE40153BB2BE545@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am using an Atmel AT91SAM9G25 board with Micron's MT29F2G08ABAEAWP NAND flash.  I am on Atmel's variant of the 3.6.9 kernel.  Specifically, I'm using https://github.com/linux4sam/linux-at91/tree/linux-3.6.9-at91 commit 5fe012d4aee98ef82df66e6763882c735902ed0f.   I have several boards in which I see the error message shown in the message subject when the device is reset due to a power cycle and the device fails to continue to load the filesystem.  On one board I erased and re-wrote the filesystem and the device is working just fine through multiple power cycles.  My questions are:

1. Is this a known issue with the version of the kernel that I am using?  I've searched this mailing list and the latest mainline kernel commits, and I didn't see anything directly related to this issue.
2. If so, is there a fix in a later kernel version?
3. If not, what would be helpful in figuring out what is going on?  I still have a bad device that I haven't touched the flash on.

Thanks,
Bryan
