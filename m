From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 07:31:55 +0900
Subject: [PATCH 1/3] ARM: S5P6442: Add Watchdog Timer map for S5P6442
In-Reply-To: <1277332317-30192-1-git-send-email-kgene.kim@samsung.com>
References: <1277332317-30192-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277332317-30192-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds definition of Watchdog Timer map.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/include/mach/map.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6442/include/mach/map.h b/arch/arm/mach-s5p6442/include/mach/map.h
index 32ca424..281d256 100644
--- a/arch/arm/mach-s5p6442/include/mach/map.h
+++ b/arch/arm/mach-s5p6442/include/mach/map.h
@@ -42,6 +42,8 @@
 
 #define S5P6442_PA_SYSTIMER   	(0xEA100000)
 
+#define S5P6442_PA_WATCHDOG	(0xEA200000)
+
 #define S5P6442_PA_UART		(0xEC000000)
 
 #define S5P_PA_UART0		(S5P6442_PA_UART + 0x0)
@@ -65,6 +67,7 @@
 #define S5P6442_PA_PCM1		0xF2500000
 
 /* compatibiltiy defines. */
+#define S3C_PA_WDT		S5P6442_PA_WATCHDOG
 #define S3C_PA_UART		S5P6442_PA_UART
 #define S3C_PA_IIC		S5P6442_PA_IIC0
 
-- 
1.6.2.5
