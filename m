From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Mar 2011 20:55:04 +0100
Subject: [PATCH] ARM: mx27: fix gpt4/5 base address
Message-ID: <1299786904-5494-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Igor Trevisan <igt1972@gmail.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx27.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index cbc43ad5..1dc1c52 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -60,8 +60,8 @@
 #define MX27_AUDMUX_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x16000)
 #define MX27_CSPI3_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x17000)
 #define MX27_MSHC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x18000)
-#define MX27_GPT5_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x19000)
-#define MX27_GPT4_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1a000)
+#define MX27_GPT4_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x19000)
+#define MX27_GPT5_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1a000)
 #define MX27_UART5_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1b000)
 #define MX27_UART6_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1c000)
 #define MX27_I2C2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1d000)
-- 
1.7.2.3
