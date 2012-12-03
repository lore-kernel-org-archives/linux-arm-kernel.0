From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Mon, 3 Dec 2012 09:39:30 -0500
Subject: at91: Status of NAND flash access
Message-ID: <91586D499ADFD74FBCFB8425266A5DE4013765CC370A@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a kernel build of 3.7-rc5 that is built for the AT91SAM9G25.  The kernel has issues when it tries to read the filesystem from NAND flash.  If I change to an NFS setup then the filesystem loads.  I've seen some patches on this list lately related to AT91 NAND flash (specifically this thread: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/133748.html) and I believe my problems may be related to this issue.  But, I'm having trouble following the thread to find the current status.

Can anyone tell me what the status is on NAND flash access for the AT91 series with the 3.7-rc5 kernel?  If this version has a known bug, is there a different suggested version I use that fixes the issue?

Thanks,
Bryan
