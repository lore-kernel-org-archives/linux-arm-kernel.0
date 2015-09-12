From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 13 Sep 2015 01:53:32 +0300
Subject: [PATCH 2/2] ARM: shmobile: silk: enable USB PHY
In-Reply-To: <1442100737.hcefR9HyDq@wasted.cogentembedded.com>
References: <1442100737.hcefR9HyDq@wasted.cogentembedded.com>
Message-ID: <3084035.cKzzM7V4Ux@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB PHY device for the SILK board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -210,3 +210,7 @@
 	pinctrl-0 = <&usb1_pins>;
 	pinctrl-names = "default";
 };
+
+&usbphy {
+	status = "okay";
+};
