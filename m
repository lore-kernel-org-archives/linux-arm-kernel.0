From: harald@ccbib.org (Harald Geyer)
Date: Mon, 12 Mar 2018 16:10:46 +0000
Subject: [PATCH 1/5] arm64: dts: allwinner: a64: Add i2c0 pins
In-Reply-To: <20180312161050.7647-1-harald@ccbib.org>
References: <20180312161050.7647-1-harald@ccbib.org>
Message-ID: <20180312161050.7647-2-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the proper pin group node to reference in board files.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b6dc31e7d91..64e452a758fa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -309,6 +309,11 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			i2c0_pins: i2c0_pins {
+				pins = "PH0", "PH1";
+				function = "i2c0";
+			};
+
 			i2c1_pins: i2c1_pins {
 				pins = "PH2", "PH3";
 				function = "i2c1";
-- 
2.11.0
