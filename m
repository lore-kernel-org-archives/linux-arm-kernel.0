From: jason.hui@linaro.org (Jason Liu)
Date: Mon, 29 Aug 2011 21:13:44 +0800
Subject: [PATCH] ARM: mx25: Add the missing IIM base definition
Message-ID: <1314623624-9999-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix the mx25 building issue of no IIM base definition

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx25.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 8dcab80..ccebf5b 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -41,6 +41,7 @@
 #define MX25_SSI2_BASE_ADDR		0x50014000
 #define MX25_SSI1_BASE_ADDR		0x50034000
 #define MX25_NFC_BASE_ADDR		0xbb000000
+#define MX25_IIM_BASE_ADDR		0x53ff0000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
 #define MX25_ESDHC1_BASE_ADDR		0x53fb4000
 #define MX25_ESDHC2_BASE_ADDR		0x53fb8000
-- 
1.7.4.1
