From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:20:26 +0200
Subject: [PATCH 11/12] ARM: imx: eukrea_mbimxsd25: use IMX_GPIO_NR
In-Reply-To: <1336461627-30315-1-git-send-email-eric@eukrea.com>
References: <1336461627-30315-1-git-send-email-eric@eukrea.com>
Message-ID: <1336461627-30315-11-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index fcc366a..dfd2da8 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -97,10 +97,10 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	MX25_PAD_CSPI1_RDY__GPIO_2_22,
 };
 
-#define GPIO_LED1	83
-#define GPIO_SWITCH1	82
-#define GPIO_SD1CD	52
-#define GPIO_LCDPWR	26
+#define GPIO_LED1		IMX_GPIO_NR(3, 19)
+#define GPIO_SWITCH1	IMX_GPIO_NR(3, 18)
+#define GPIO_SD1CD		IMX_GPIO_NR(2, 20)
+#define GPIO_LCDPWR		IMX_GPIO_NR(1, 26)
 #define	GPIO_SPI1_SS0	IMX_GPIO_NR(1, 16)
 #define	GPIO_SPI1_SS1	IMX_GPIO_NR(1, 17)
 #define	GPIO_SPI1_IRQ	IMX_GPIO_NR(2, 22)
-- 
1.7.7.6
