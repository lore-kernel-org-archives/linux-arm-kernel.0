From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 14:26:43 +0100
Subject: [PATCH 4/5] clk: meson-gxbb: Expose GP0 dt-bindings clock id
In-Reply-To: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489411604-18700-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exposes the GP0 PLL clock id in the dt bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.h              | 2 +-
 include/dt-bindings/clock/gxbb-clkc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 7f99bf6..89f1a2c 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -179,7 +179,7 @@
 /* CLKID_FCLK_DIV4 */
 #define CLKID_FCLK_DIV5		  7
 #define CLKID_FCLK_DIV7		  8
-#define CLKID_GP0_PLL		  9
+/* CLKID_GP0_PLL */
 #define CLKID_MPEG_SEL		  10
 #define CLKID_MPEG_DIV		  11
 /* CLKID_CLK81 */
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 692846c..febef8b 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -10,6 +10,7 @@
 #define CLKID_FCLK_DIV2		4
 #define CLKID_FCLK_DIV3		5
 #define CLKID_FCLK_DIV4		6
+#define CLKID_GP0_PLL		9
 #define CLKID_CLK81		12
 #define CLKID_MPLL2		15
 #define CLKID_SPI		34
-- 
1.9.1
