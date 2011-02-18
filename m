From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 18 Feb 2011 18:18:26 +0100
Subject: [PATCH 1/2] arm: mx23: names of interrupts and base address should
	match for I2C
In-Reply-To: <1298049507-6987-1-git-send-email-w.sang@pengutronix.de>
References: <1298049507-6987-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1298049507-6987-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/include/mach/mx23.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
index 4768402..9b610b1 100644
--- a/arch/arm/mach-mxs/include/mach/mx23.h
+++ b/arch/arm/mach-mxs/include/mach/mx23.h
@@ -57,7 +57,7 @@
 #define MX23_AUDIOIN_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x04c000)
 #define MX23_LRADC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x050000)
 #define MX23_SPDIF_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x054000)
-#define MX23_I2C0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x058000)
+#define MX23_I2C_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x058000)
 #define MX23_RTC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x05c000)
 #define MX23_PWM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x064000)
 #define MX23_TIMROT_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x068000)
-- 
1.7.2.3
