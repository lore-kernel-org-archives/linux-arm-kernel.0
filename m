From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 24 May 2014 02:29:35 +0400
Subject: [PATCH v2 2/2] ARM: shmobile: lager: enable USB PHY
In-Reply-To: <201405240226.27820.sergei.shtylyov@cogentembedded.com>
References: <201405240226.27820.sergei.shtylyov@cogentembedded.com>
Message-ID: <201405240229.36579.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB PHY device for the Lager board. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- refreshed the patch.

 arch/arm/boot/dts/r8a7790-lager.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
+++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
@@ -350,3 +350,7 @@
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
 };
+
+&usbphy {
+	status = "okay";
+};
