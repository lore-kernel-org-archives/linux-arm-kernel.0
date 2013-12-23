From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Dec 2013 16:37:05 +0800
Subject: [PATCH 3/4] pinctrl: sunxi: Add Allwinner A20 clock output pin
 functions
In-Reply-To: <1387787827-11341-1-git-send-email-wens@csie.org>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
Message-ID: <1387787827-11341-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/pinctrl-sunxi-pins.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi-pins.h b/drivers/pinctrl/pinctrl-sunxi-pins.h
index 2c7446a..567bc44 100644
--- a/drivers/pinctrl/pinctrl-sunxi-pins.h
+++ b/drivers/pinctrl/pinctrl-sunxi-pins.h
@@ -3774,12 +3774,14 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "clk_out_a"),
 		  SUNXI_FUNCTION_IRQ(0x5, 24)),		/* EINT24 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PI13,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
 		  SUNXI_FUNCTION(0x3, "uart6"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clk_out_b"),
 		  SUNXI_FUNCTION_IRQ(0x5, 25)),		/* EINT25 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN_PI14,
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
1.8.5.2
