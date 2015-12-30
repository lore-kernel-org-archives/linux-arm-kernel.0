From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 30 Dec 2015 15:39:03 +0200
Subject: [PATCH 4/6] ARM: dts: am57xx: sbc-am57x: fix UART3 pinmux
In-Reply-To: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
References: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1451482745-1820-5-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix UART3 pinmux.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 0f1d425..988e996 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -25,8 +25,8 @@
 &dra7_pmx_core {
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT_SLEW | MUX_MODE2)	/* uart2_ctsn.uart3_rxd */
-			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT_SLEW | MUX_MODE1)	/* uart2_rtsn.uart3_txd */
+			DRA7XX_CORE_IOPAD(0x3648, PIN_INPUT_SLEW | MUX_MODE0)	/* uart3_rxd */
+			DRA7XX_CORE_IOPAD(0x364c, PIN_INPUT_SLEW | MUX_MODE0)	/* uart3_txd */
 		>;
 	};
 
-- 
1.9.1
