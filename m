From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:11 +0900
Subject: [PATCH 01/14] ARM: S5PV310: Adds clock addresses for S5PV310
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds definition of clock address.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/regs-clock.h |   29 +++++++++++++++++++++-
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/regs-clock.h b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
index 7727b45..eda07fd 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
@@ -26,11 +26,23 @@
 
 #define S5P_CLKSRC_TOP0			S5P_CLKREG(0x0C210)
 #define S5P_CLKSRC_TOP1			S5P_CLKREG(0x0C214)
-
+#define S5P_CLKSRC_CAM			S5P_CLKREG(0x0C220)
+#define S5P_CLKSRC_IMAGE		S5P_CLKREG(0x0C230)
+#define S5P_CLKSRC_LCD0			S5P_CLKREG(0x0C234)
+#define S5P_CLKSRC_LCD1			S5P_CLKREG(0x0C238)
+#define S5P_CLKSRC_FSYS			S5P_CLKREG(0x0C240)
 #define S5P_CLKSRC_PERIL0		S5P_CLKREG(0x0C250)
+#define S5P_CLKSRC_PERIL1		S5P_CLKREG(0x0C254)
 
 #define S5P_CLKDIV_TOP			S5P_CLKREG(0x0C510)
-
+#define S5P_CLKDIV_CAM			S5P_CLKREG(0x0C520)
+#define S5P_CLKDIV_IMAGE		S5P_CLKREG(0x0C530)
+#define S5P_CLKDIV_LCD0			S5P_CLKREG(0x0C534)
+#define S5P_CLKDIV_LCD1			S5P_CLKREG(0x0C538)
+#define S5P_CLKDIV_FSYS0		S5P_CLKREG(0x0C540)
+#define S5P_CLKDIV_FSYS1		S5P_CLKREG(0x0C544)
+#define S5P_CLKDIV_FSYS2		S5P_CLKREG(0x0C548)
+#define S5P_CLKDIV_FSYS3		S5P_CLKREG(0x0C54C)
 #define S5P_CLKDIV_PERIL0		S5P_CLKREG(0x0C550)
 #define S5P_CLKDIV_PERIL1		S5P_CLKREG(0x0C554)
 #define S5P_CLKDIV_PERIL2		S5P_CLKREG(0x0C558)
@@ -38,6 +50,19 @@
 #define S5P_CLKDIV_PERIL4		S5P_CLKREG(0x0C560)
 #define S5P_CLKDIV_PERIL5		S5P_CLKREG(0x0C564)
 
+#define S5P_CLKSRC_MASK_TOP		S5P_CLKREG(0x0C310)
+#define S5P_CLKSRC_MASK_CAM		S5P_CLKREG(0x0C320)
+#define S5P_CLKSRC_MASK_LCD0		S5P_CLKREG(0x0C334)
+#define S5P_CLKSRC_MASK_LCD1		S5P_CLKREG(0x0C338)
+#define S5P_CLKSRC_MASK_FSYS		S5P_CLKREG(0x0C340)
+#define S5P_CLKSRC_MASK_PERIL0		S5P_CLKREG(0x0C350)
+#define S5P_CLKSRC_MASK_PERIL1		S5P_CLKREG(0x0C354)
+
+#define S5P_CLKGATE_IP_CAM		S5P_CLKREG(0x0C920)
+#define S5P_CLKGATE_IP_IMAGE		S5P_CLKREG(0x0C930)
+#define S5P_CLKGATE_IP_LCD0		S5P_CLKREG(0x0C934)
+#define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
+#define S5P_CLKGATE_IP_FSYS		S5P_CLKREG(0x0C940)
 #define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x0C950)
 
 #define S5P_CLKSRC_CORE			S5P_CLKREG(0x10200)
-- 
1.6.2.5
