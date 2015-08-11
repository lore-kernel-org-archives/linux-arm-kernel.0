From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 11 Aug 2015 18:19:25 +0200
Subject: [PATCH] pinctrl: sun4i: add spdif to pin description.
Message-ID: <1439309965-9530-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 7376a97..daf7dec 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -135,7 +135,8 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "ir0")),		/* TX */
+		  SUNXI_FUNCTION(0x2, "ir0"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spdif")),        /* MCLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
@@ -176,11 +177,13 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "i2s"),		/* DI */
-		  SUNXI_FUNCTION(0x3, "ac97")),		/* DI */
+		  SUNXI_FUNCTION(0x3, "ac97"),		/* DI */
+		  SUNXI_FUNCTION(0x4, "spdif")),        /* DI */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "spi2")),		/* CS1 */
+		  SUNXI_FUNCTION(0x2, "spi2"),		/* CS1 */
+		  SUNXI_FUNCTION(0x4, "spdif")),        /* DO */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.5.0
