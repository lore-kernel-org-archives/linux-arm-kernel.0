From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 08 Feb 2012 10:10:30 +0900
Subject: [PATCH v2 1/2] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <20120105145425.GW11810@n2100.arm.linux.org.uk>
References: <1323654668-32504-1-git-send-email-boojin.kim@samsung.com>
 <20120105145425.GW11810@n2100.arm.linux.org.uk>
Message-ID: <003101cce5fe$734b9990$59e2ccb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
>
> Now that the PL330 code is entirely out of arch/arm, the header should no
> longer be in asm/hardware/pl330.h.
>
> Definitions private to the driver should be in drivers/dma/pl330.c or a
> header file co-located.  Other definitions for interfaces to that driver
> (eg, platform data) should be in include/linux/amba.
>
> That can be the subject of a follow-up patch if this is already finalized.
>
Sorry to late response. I believed my reply was sent. But, It maybe be not.
Anyway.. get to the point.
Pl08x also has asm/hardware/pl080.h to include hw specific information.
It seems to be same purpose with asm/hardware/pl330.h
Do you mean both asm/hardware/pl080.h and asm/hardware/pl330.h should be moved to include/linux/amba?

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
