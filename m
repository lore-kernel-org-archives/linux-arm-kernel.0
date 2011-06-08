From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed,  8 Jun 2011 17:56:38 +0200
Subject: [PATCH] ARM: mx53: Fix the base addresses for the DDR memory regions
Message-ID: <1307548598-12963-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

This patch applied to the imx-for-3.0 branch of
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=summary

regards, Marc

 arch/arm/plat-mxc/include/mach/mx53.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 5a2104e..e14a4f0 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -145,8 +145,8 @@
 /*
  * Memory regions and CS
  */
-#define MX53_CSD0_BASE_ADDR		0x90000000
-#define MX53_CSD1_BASE_ADDR		0xA0000000
+#define MX53_CSD0_BASE_ADDR		0x70000000
+#define MX53_CSD1_BASE_ADDR		0xB0000000
 #define MX53_CS0_BASE_ADDR		0xF0000000
 #define MX53_CS1_32MB_BASE_ADDR	0xF2000000
 #define MX53_CS1_64MB_BASE_ADDR		0xF4000000
-- 
1.7.4.1
