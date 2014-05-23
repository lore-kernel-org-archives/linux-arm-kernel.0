From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 24 May 2014 02:38:01 +0400
Subject: [PATCH v2 2/3] ARM: shmobile: koelsch: enable USB PHY
In-Reply-To: <201405240234.47303.sergei.shtylyov@cogentembedded.com>
References: <201405240234.47303.sergei.shtylyov@cogentembedded.com>
Message-ID: <201405240238.02279.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB PHY device for the Koelsch board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- fixed the wrong board name in the changelog;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-koelsch.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -430,3 +430,7 @@
 	pinctrl-0 = <&usb1_pins>;
 	pinctrl-names = "default";
 };
+
+&usbphy {
+	status = "okay";
+};
