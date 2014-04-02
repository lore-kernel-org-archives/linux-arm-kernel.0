From: stefan@agner.ch (stefan at agner.ch)
Date: Wed,  2 Apr 2014 19:05:38 +0200
Subject: [PATCH v2 2/2] ARM: dts: SPEAr: fix wrong stmpe-ts bindings
In-Reply-To: <cover.1396457876.git.stefan@agner.ch>
References: <cover.1396457876.git.stefan@agner.ch>
Message-ID: <d4a7f6bcdf6ec00970aabb9ff501c7d342f37bd7.1396457876.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

Fix bindings for STMPE touchscreen controller to match the documented
bindings and the actual bindings used by the driver.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/spear1310-evb.dts | 18 +++++++++---------
 arch/arm/boot/dts/spear1340-evb.dts | 18 +++++++++---------
 arch/arm/boot/dts/spear320-hmi.dts  | 20 ++++++++++----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index b56a801..fe2ece2 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -369,15 +369,15 @@
 
 					stmpe_touchscreen {
 						compatible = "st,stmpe-ts";
-						ts,sample-time = <4>;
-						ts,mod-12b = <1>;
-						ts,ref-sel = <0>;
-						ts,adc-freq = <1>;
-						ts,ave-ctrl = <1>;
-						ts,touch-det-delay = <2>;
-						ts,settling = <2>;
-						ts,fraction-z = <7>;
-						ts,i-drive = <1>;
+						st,sample-time = <4>;
+						st,mod-12b = <1>;
+						st,ref-sel = <0>;
+						st,adc-freq = <1>;
+						st,ave-ctrl = <1>;
+						st,touch-det-delay = <2>;
+						st,settling = <2>;
+						st,fraction-z = <7>;
+						st,i-drive = <1>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index d6c30ae..d3dcba9 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -480,15 +480,15 @@
 
 					stmpe_touchscreen {
 						compatible = "st,stmpe-ts";
-						ts,sample-time = <4>;
-						ts,mod-12b = <1>;
-						ts,ref-sel = <0>;
-						ts,adc-freq = <1>;
-						ts,ave-ctrl = <1>;
-						ts,touch-det-delay = <2>;
-						ts,settling = <2>;
-						ts,fraction-z = <7>;
-						ts,i-drive = <1>;
+						st,sample-time = <4>;
+						st,mod-12b = <1>;
+						st,ref-sel = <0>;
+						st,adc-freq = <1>;
+						st,ave-ctrl = <1>;
+						st,touch-det-delay = <2>;
+						st,settling = <2>;
+						st,fraction-z = <7>;
+						st,i-drive = <1>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 3075d2d..2a5d013 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -256,17 +256,17 @@
 					};
 
 					stmpe610-ts {
-						compatible = "stmpe,ts";
+						compatible = "st,stmpe-ts";
 						reg = <0>;
-						ts,sample-time = <4>;
-						ts,mod-12b = <1>;
-						ts,ref-sel = <0>;
-						ts,adc-freq = <1>;
-						ts,ave-ctrl = <1>;
-						ts,touch-det-delay = <3>;
-						ts,settling = <4>;
-						ts,fraction-z = <7>;
-						ts,i-drive = <1>;
+						st,sample-time = <4>;
+						st,mod-12b = <1>;
+						st,ref-sel = <0>;
+						st,adc-freq = <1>;
+						st,ave-ctrl = <1>;
+						st,touch-det-delay = <3>;
+						st,settling = <4>;
+						st,fraction-z = <7>;
+						st,i-drive = <1>;
 					};
 				};
 			};
-- 
1.9.1
