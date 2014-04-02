From: stefan@agner.ch (stefan at agner.ch)
Date: Wed,  2 Apr 2014 19:05:37 +0200
Subject: [PATCH v2 1/2] ARM: dts: mx5: fix wrong stmpe-ts bindings
In-Reply-To: <cover.1396457876.git.stefan@agner.ch>
References: <cover.1396457876.git.stefan@agner.ch>
Message-ID: <94a8b96fe30ce97ec89e49ef6470271888024256.1396457876.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

Fix bindings for STMPE touchscreen controller to match the documented
bindings and the actual bindings used by the driver.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 7d304d0..e97f298 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -165,17 +165,17 @@
 		irq-trigger = <0x1>;
 
 		stmpe_touchscreen {
-			compatible = "stmpe,ts";
+			compatible = "st,stmpe-ts";
 			reg = <0>;
-			ts,sample-time = <4>;
-			ts,mod-12b = <1>;
-			ts,ref-sel = <0>;
-			ts,adc-freq = <1>;
-			ts,ave-ctrl = <3>;
-			ts,touch-det-delay = <3>;
-			ts,settling = <4>;
-			ts,fraction-z = <7>;
-			ts,i-drive = <1>;
+			st,sample-time = <4>;
+			st,mod-12b = <1>;
+			st,ref-sel = <0>;
+			st,adc-freq = <1>;
+			st,ave-ctrl = <3>;
+			st,touch-det-delay = <3>;
+			st,settling = <4>;
+			st,fraction-z = <7>;
+			st,i-drive = <1>;
 		};
 	};
 
-- 
1.9.1
