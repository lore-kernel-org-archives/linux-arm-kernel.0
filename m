From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Thu, 19 Nov 2009 12:45:11 +0100
Subject: Can anyone help test Cortex A9 patches?
In-Reply-To: <20091119090328.GC13376@n2100.arm.linux.org.uk>
References: <20091119090328.GC13376@n2100.arm.linux.org.uk>
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B16062435D2@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
We have Cortex-A9 hardware (U8500) at ST-Ericsson. We can test your patches.
Let me know how frequently you would like to test these patches
on recent kernels? And do you have some specific test scenarios
wherein we can reproduce this Cortex A9's data corruption issue?

Srinidhi

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux
Sent: Thursday, November 19, 2009 2:33 PM
To: linux-arm-kernel at lists.infradead.org
Subject: Can anyone help test Cortex A9 patches?

Hi,

I need help testing Cortex A9 patches.  What I need is someone with a
fairly fully fledged Cortex A9 platform with the ability to build and
test recent kernels - and therefore be able to test my patches without
modification.

Specifically, I'm looking for someone who can reproduce data corruption
on DMA transfers from devices caused by Cortex A9's speculative prefetching

Unfortunately, I have no way to reproduce this problem here (I have no
Cortex A9 hardware), and as such I can't test the fixes.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
