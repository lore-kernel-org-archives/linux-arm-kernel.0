From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:16 +0100
Subject: [PATCH 02/17] ARM: pxa/raumfeld: add GPIO definitions
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-3-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   43 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 89ead5f..075e337 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -33,6 +33,49 @@
 #include "devices.h"
 #include "clock.h"
 
+/* common GPIO	definitions */
+
+/* inputs */
+#define GPIO_ON_OFF		MFP_PIN_GPIO14
+#define GPIO_VOLENC_A		MFP_PIN_GPIO19
+#define GPIO_VOLENC_B		MFP_PIN_GPIO20
+#define GPIO_CHARGE_DONE	MFP_PIN_GPIO23
+#define GPIO_CHARGE_IND		MFP_PIN_GPIO27
+#define GPIO_TOUCH_IRQ		MFP_PIN_GPIO32
+#define GPIO_ETH_IRQ		MFP_PIN_GPIO40
+#define GPIO_SPI_MISO		MFP_PIN_GPIO98
+#define GPIO_ACCEL_IRQ		MFP_PIN_GPIO104
+#define GPIO_RESCUE_BOOT	MFP_PIN_GPIO115
+#define GPIO_DOCK_DETECT	MFP_PIN_GPIO116
+#define GPIO_KEY1		MFP_PIN_GPIO117
+#define GPIO_KEY2		MFP_PIN_GPIO118
+#define GPIO_KEY3		MFP_PIN_GPIO119
+#define GPIO_CHARGE_USB_OK	MFP_PIN_GPIO112
+#define GPIO_CHARGE_DC_OK	MFP_PIN_GPIO101
+#define GPIO_CHARGE_USB_SUSP	MFP_PIN_GPIO102
+
+/* outputs */
+#define GPIO_SHUTDOWN_SUPPLY	MFP_PIN_GPIO16
+#define GPIO_SHUTDOWN_BATT	MFP_PIN_GPIO18
+#define GPIO_CHRG_PEN2		MFP_PIN_GPIO31
+#define GPIO_TFT_VA_EN		MFP_PIN_GPIO33
+#define GPIO_SPDIF_CS		MFP_PIN_GPIO34
+#define GPIO_LED2		MFP_PIN_GPIO35
+#define GPIO_LED1		MFP_PIN_GPIO36
+#define GPIO_SPDIF_RESET	MFP_PIN_GPIO38
+#define GPIO_SPI_CLK		MFP_PIN_GPIO95
+#define GPIO_MCLK_DAC_CS	MFP_PIN_GPIO96
+#define GPIO_SPI_MOSI		MFP_PIN_GPIO97
+#define GPIO_W1_PULLUP_ENABLE	MFP_PIN_GPIO105
+#define GPIO_MCLK_RESET		MFP_PIN_GPIO111
+#define GPIO_W2W_RESET		MFP_PIN_GPIO113
+#define GPIO_W2W_PDN		MFP_PIN_GPIO114
+#define GPIO_CODEC_RESET	MFP_PIN_GPIO120
+#define GPIO_AUDIO_VA_ENABLE	MFP_PIN_GPIO124
+#define GPIO_ACCEL_CS		MFP_PIN_GPIO125
+#define GPIO_ONE_WIRE		MFP_PIN_GPIO126
+#define GPIO_DISPLAY_ENABLE	MFP_PIN_GPIO106
+
 /*
  * GPIO configuration (common for all hardware platforms)
  */
-- 
1.6.5.2
