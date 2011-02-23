From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed, 23 Feb 2011 16:58:37 +0000
Subject: [PATCH 2/4] MX1: Rename SPI interrupt name and base address.
In-Reply-To: <1298480319-72386-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1298480319-72386-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1298480319-72386-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/plat-mxc/include/mach/mx1.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 75d9621..7c871b8 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -54,13 +54,13 @@
 #define MX1_AIPI2_BASE_ADDR		(0x10000 + MX1_IO_BASE_ADDR)
 #define MX1_SIM_BASE_ADDR		(0x11000 + MX1_IO_BASE_ADDR)
 #define MX1_USBD_BASE_ADDR		(0x12000 + MX1_IO_BASE_ADDR)
-#define MX1_SPI1_BASE_ADDR		(0x13000 + MX1_IO_BASE_ADDR)
+#define MX1_CSPI1_BASE_ADDR		(0x13000 + MX1_IO_BASE_ADDR)
 #define MX1_MMC_BASE_ADDR		(0x14000 + MX1_IO_BASE_ADDR)
 #define MX1_ASP_BASE_ADDR		(0x15000 + MX1_IO_BASE_ADDR)
 #define MX1_BTA_BASE_ADDR		(0x16000 + MX1_IO_BASE_ADDR)
 #define MX1_I2C_BASE_ADDR		(0x17000 + MX1_IO_BASE_ADDR)
 #define MX1_SSI_BASE_ADDR		(0x18000 + MX1_IO_BASE_ADDR)
-#define MX1_SPI2_BASE_ADDR		(0x19000 + MX1_IO_BASE_ADDR)
+#define MX1_CSPI2_BASE_ADDR		(0x19000 + MX1_IO_BASE_ADDR)
 #define MX1_MSHC_BASE_ADDR		(0x1A000 + MX1_IO_BASE_ADDR)
 #define MX1_CCM_BASE_ADDR		(0x1B000 + MX1_IO_BASE_ADDR)
 #define MX1_SCM_BASE_ADDR		(0x1B804 + MX1_IO_BASE_ADDR)
@@ -112,7 +112,8 @@
 #define MX1_PWM_INT		34
 #define MX1_SDHC_INT		35
 #define MX1_INT_I2C		39
-#define MX1_CSPI_INT		41
+#define MX1_INT_CSPI2		40
+#define MX1_INT_CSPI1		41
 #define MX1_SSI_TX_INT		42
 #define MX1_SSI_TX_ERR_INT	43
 #define MX1_SSI_RX_INT		44
-- 
1.7.3.4
