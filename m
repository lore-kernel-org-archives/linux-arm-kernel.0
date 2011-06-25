From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 25 Jun 2011 13:28:53 -0300
Subject: [PATCH v2] ARM: mach-mx5/mx53_ard: Add missing definition
Message-ID: <1309019333-1977-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 9203d59 (ARM:mach-mx5/mx53_ard: Add I2C2 and I2C3 support) missed to include
the define for ARD_I2CPORTEXP_B.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Used tab instead of spaces

 arch/arm/mach-mx5/board-mx53_ard.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 70ae25e..b94ddeb 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -38,6 +38,7 @@
 #define ARD_ETHERNET_INT_B	IMX_GPIO_NR(2, 31)
 #define ARD_SD1_CD		IMX_GPIO_NR(1, 1)
 #define ARD_SD1_WP		IMX_GPIO_NR(1, 9)
+#define ARD_I2CPORTEXP_B	IMX_GPIO_NR(2, 3)
 
 static iomux_v3_cfg_t mx53_ard_pads[] = {
 	/* UART1 */
-- 
1.7.1
