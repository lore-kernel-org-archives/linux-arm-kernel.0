From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 23 Jul 2014 01:17:18 +0400
Subject: [PATCH v3 2/2] ARM: shmobile: lager: enable USB PHY
In-Reply-To: <201407230113.46444.sergei.shtylyov@cogentembedded.com>
References: <201407230113.46444.sergei.shtylyov@cogentembedded.com>
Message-ID: <201407230117.19081.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB PHY device for the Lager board. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- refreshed the patch.

Changes in version 2:
- refreshed the patch.

 arch/arm/boot/dts/r8a7790-lager.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
+++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
@@ -405,3 +405,7 @@
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
 };
+
+&usbphy {
+	status = "okay";
+};
