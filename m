From: cxie4@marvell.com (Chao Xie)
Date: Tue, 14 Dec 2010 23:46:39 -0800
Subject: arm cortex a9 localtimer and global timer
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D15345BE407@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
In the latest arm kernel, I find that smp_twd.c has implemented local timer for cortex a9 MPcore. In the spec, there is global timer that shared by all MPcore. I did not find any implements in the arm kernel. What is the strategy of using these two kinds of timer? I find that some SOCs have additional timer which is not the local timer or global timer in MPcore. Then what is the strategy of using this kind of timer with local timer and global timer in the kernel? Thanks.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101214/aac289c1/attachment-0001.html>
