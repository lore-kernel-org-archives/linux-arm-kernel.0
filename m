From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 19 Nov 2009 15:19:40 +0530
Subject: Can anyone help test Cortex A9 patches?
In-Reply-To: <20091119090328.GC13376@n2100.arm.linux.org.uk>
References: <20091119090328.GC13376@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBC430A4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King -
> ARM Linux
> Sent: Thursday, November 19, 2009 2:33 PM
> To: linux-arm-kernel at lists.infradead.org
> Subject: Can anyone help test Cortex A9 patches?
> 
> Hi,
> 
> I need help testing Cortex A9 patches.  What I need is someone with
> a
> fairly fully fledged Cortex A9 platform with the ability to build
> and
> test recent kernels - and therefore be able to test my patches
> without
> modification.
> 
> Specifically, I'm looking for someone who can reproduce data
> corruption
> on DMA transfers from devices caused by Cortex A9's speculative
> prefetching
> 
> Unfortunately, I have no way to reproduce this problem here (I have
> no
> Cortex A9 hardware), and as such I can't test the fixes.

I can test your patches on A9 hardware (OMAP4) over this weekend. Couple of constraints with codebase I have
1. It's still on 2.6.31. Can you patches be applied on 2.6.31 too ?
2. Do you have the testcase for the above mentioned scenario or do I need to make one?

Regards,
Santosh
