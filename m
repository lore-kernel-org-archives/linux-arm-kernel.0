From: zhaoy@marvell.com (zhaoy)
Date: Tue, 28 Feb 2012 15:27:39 +0800
Subject: [PATCH 07/13] DMA:mmp:remove redundant dma drivers
In-Reply-To: <Y>
References: <Y>
Message-ID: <1330414065-2949-8-git-send-email-zhaoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1.remove old dma drivers

Change-Id: I96ffed95012a4f3e855c2f6c184646a798a0ee7d
Signed-off-by: zhaoy <zhaoy@marvell.com>
---
 arch/arm/mach-mmp/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index a5d5ba7..d06adcb 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -9,9 +9,9 @@ obj-$(CONFIG_FB_PXA168)		+= onboard/
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o irq-pxa168.o
 obj-$(CONFIG_CPU_PXA910)	+= pxa910.o irq-pxa168.o sram.o pxa910-squ.o \
 clock.o
-obj-$(CONFIG_CPU_MMP2)		+= mmp2.o irq-mmp2.o clock.o mmp_dma.o \
+obj-$(CONFIG_CPU_MMP2)		+= mmp2.o irq-mmp2.o clock.o \
 sram.o mmp2_sspa.o mmp2_fuse.o clock-audio.o
-obj-$(CONFIG_CPU_MMP3)		+= mmp3.o irq-mmp3.o mmp_dma.o mmp2_sspa.o \
+obj-$(CONFIG_CPU_MMP3)		+= mmp3.o irq-mmp3.o mmp2_sspa.o \
 sram.o delay-mmp3.o clock-mmp3.o dvfs-mmp3.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-- 
1.7.0.4
