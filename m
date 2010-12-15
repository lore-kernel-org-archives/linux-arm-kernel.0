From: saeed@marvell.com (Saeed Bishara)
Date: Wed, 15 Dec 2010 10:10:44 +0200
Subject: [PATCH 04/16] ARM: Dove: Remove PXA compatibility IRQ defines.
In-Reply-To: <20101215020306.GW15575@mail.wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020306.GW15575@mail.wantstofly.org>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FE148BBBCFF@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: Lennert Buytenhek [mailto:buytenh at wantstofly.org] 
>Sent: Wednesday, December 15, 2010 4:03 AM
>To: Saeed Bishara
>Cc: linux-arm-kernel at lists.infradead.org
>Subject: [PATCH 04/16] ARM: Dove: Remove PXA compatibility IRQ defines.
>
>These are not currently used anywhere, but when the relevant
>peripherals are enabled on the Dove port, the IRQ numbers should be
>passed into the drivers via platform device resources rather than
>having the drivers get them from platform headers directly.
>
>Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
>---
> arch/arm/mach-dove/include/mach/irqs.h |    7 +------
> 1 files changed, 1 insertions(+), 6 deletions(-)
>
>diff --git a/arch/arm/mach-dove/include/mach/irqs.h 
>b/arch/arm/mach-dove/include/mach/irqs.h
>index 4668146..03d401d 100644
>--- a/arch/arm/mach-dove/include/mach/irqs.h
>+++ b/arch/arm/mach-dove/include/mach/irqs.h
>@@ -92,10 +92,5 @@
> 
> #define NR_IRQS			(IRQ_DOVE_PMU_START + 
>NR_PMU_IRQS)
> 
>-/* Required for compatability with PXA AC97 driver.	*/
>-#define IRQ_AC97		IRQ_DOVE_AC97
>-/* Required for compatability with PXA DMA driver.	*/
>-#define IRQ_DMA			IRQ_DOVE_PDMA
>-/* Required for compatability with PXA NAND driver 	*/
>-#define IRQ_NAND		IRQ_DOVE_NAND
>+
> #endif
>-- 
Acked-by: Saeed Bishara <saeed@marvell.com>

saeed
