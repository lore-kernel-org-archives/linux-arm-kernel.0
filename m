From: h.feurstein@gmail.com (Hubert Feurstein)
Date: Tue, 17 Nov 2009 12:38:20 +0100
Subject: [PATCH] ep93xx: add missing file headers
Message-ID: <200911171238.20181.h.feurstein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/clkdev.h |    4 ++++
 arch/arm/mach-ep93xx/include/mach/dma.h    |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/clkdev.h b/arch/arm/mach-ep93xx/include/mach/clkdev.h
index 04b37a8..50cb991 100644
--- a/arch/arm/mach-ep93xx/include/mach/clkdev.h
+++ b/arch/arm/mach-ep93xx/include/mach/clkdev.h
@@ -1,3 +1,7 @@
+/*
+ * arch/arm/mach-ep93xx/include/mach/clkdev.h
+ */
+
 #ifndef __ASM_MACH_CLKDEV_H
 #define __ASM_MACH_CLKDEV_H
 
diff --git a/arch/arm/mach-ep93xx/include/mach/dma.h b/arch/arm/mach-ep93xx/include/mach/dma.h
index ef6bd9d..3a5961d 100644
--- a/arch/arm/mach-ep93xx/include/mach/dma.h
+++ b/arch/arm/mach-ep93xx/include/mach/dma.h
@@ -1,3 +1,7 @@
+/*
+ * arch/arm/mach-ep93xx/include/mach/dma.h
+ */
+
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
 
-- 
1.6.4.4
