From: raashidmuhammed@zilogic.com (Raashid Muhammed)
Date: Thu, 26 May 2016 12:48:25 +0530
Subject: [PATCH v2 1/2] ARM: at91/dt: at91sam9260: Remove leading zeros in
 OHCI node.
Message-ID: <0b33151de87d9249a49a90c3a17ee0d112d45043.1464245706.git.raashidmuhammed@zilogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Raashid Muhammed <raashidmuhammed@zilogic.com>

Remove leading zeros in OHCI node for at91sam9260 based boards.

Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
---
 arch/arm/boot/dts/aks-cdu.dts               | 2 +-
 arch/arm/boot/dts/animeo_ip.dts             | 2 +-
 arch/arm/boot/dts/at91-foxg20.dts           | 2 +-
 arch/arm/boot/dts/at91-kizbox.dts           | 2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts        | 2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 2 +-
 arch/arm/boot/dts/ethernut5.dts             | 2 +-
 arch/arm/boot/dts/evk-pro3.dts              | 2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/aks-cdu.dts
index d9c50fb..5b1bf92 100644
--- a/arch/arm/boot/dts/aks-cdu.dts
+++ b/arch/arm/boot/dts/aks-cdu.dts
@@ -57,7 +57,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 0962f2f..8bcbad3 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -114,7 +114,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			atmel,vbus-gpio = <&pioB 15 GPIO_ACTIVE_LOW>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
index 6bf873e..42a535d 100644
--- a/arch/arm/boot/dts/at91-foxg20.dts
+++ b/arch/arm/boot/dts/at91-foxg20.dts
@@ -128,7 +128,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 229e989..0e3f34e 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -54,7 +54,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <1>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index 4f2eebf..5309e19 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -111,7 +111,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index d4884dd..af5ba31 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -1007,7 +1007,7 @@
 			status = "disabled";
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index e9cc99b..1395b30 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -170,7 +170,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 2430443..298ee2f 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -77,7 +77,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index f72969e..312d3e8 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -46,7 +46,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 9beea89..12119b5 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -90,7 +90,7 @@
 			};
 		};
 
-		usb0: ohci at 00500000 {
+		usb0: ohci at 500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
-- 
2.1.4
