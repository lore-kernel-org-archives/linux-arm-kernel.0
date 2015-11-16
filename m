From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 16 Nov 2015 18:56:34 +0800
Subject: [PATCH v2 PART-RESEND 1/2] ARM: dts: berlin: correct BG2Q's sdhci2
 2nd clock
In-Reply-To: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
References: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
Message-ID: <1447671395-8023-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The optional 2nd clock is CLKID_SDIO.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 155430a..145dd33 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -135,7 +135,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_NFC>;
+			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_SDIO>;
 			clock-names = "io", "core";
 			status = "disabled";
 		};
-- 
2.6.2
