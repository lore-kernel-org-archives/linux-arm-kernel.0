From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 31 May 2013 11:11:33 +0800
Subject: [PATCH 2/2] ARM: dts: add the watchdog nodes for at91 boards
In-Reply-To: <1369969893-7992-1-git-send-email-wenyou.yang@atmel.com>
References: <1369969744-3428-1-git-send-email-wenyou.yang@atmel.com>
 <1369969893-7992-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1369969893-7992-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

boards include:
at91sam9263ek, at91sam9g20ek, at91sam9m10g45ek, at91sam9n12ek, at91sam9x5ek

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts         |    4 ++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    4 ++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |    4 ++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |    4 ++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |    4 ++++
 5 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 3b82d91..9143842 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -89,6 +89,10 @@
 					reg = <0>;
 				};
 			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 6a92c5b..6d6b888 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -106,6 +106,10 @@
 					reg = <1>;
 				};
 			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 51d9251b5..03f391a 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -59,6 +59,10 @@
 				status = "okay";
 			};
 
+			watchdog at fffffd40 {
+				status = "okay";
+			};
+
 			mmc0: mmc at fff80000 {
 				pinctrl-0 = <
 					&pinctrl_board_mmc0
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index d30e48b..32e073f 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -77,6 +77,10 @@
 					reg = <0>;
 				};
 			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 1fa48d2..e60b05a 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -56,6 +56,10 @@
 				status = "okay";
 			};
 
+			watchdog at fffffe40 {
+				status = "okay";
+			};
+
 			pinctrl at fffff400 {
 				mmc0 {
 					pinctrl_board_mmc0: mmc0-board {
-- 
1.7.9.5
