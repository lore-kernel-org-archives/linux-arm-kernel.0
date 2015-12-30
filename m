From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 30 Dec 2015 15:39:04 +0200
Subject: [PATCH 5/6] ARM: dts: am57xx: cl-som-am57x: fix CPSW EMAC pinmux
In-Reply-To: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
References: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1451482745-1820-6-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix CPSW EMAC pinmux

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index cb9a518..9e0153a 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -167,7 +167,7 @@
 			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d20.rgmii1_rd3 */
 			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d21.rgmii1_rd2 */
 			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d22.rgmii1_rd1 */
-			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT_PULLUP | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d23.rgmii1_rd0 */
 		>;
 	};
 
-- 
1.9.1
