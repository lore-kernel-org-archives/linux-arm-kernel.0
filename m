From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 02 Oct 2015 01:06:23 +0300
Subject: [PATCH v2 2/2] ARM: shmobile: silk: enable USB PHY
In-Reply-To: <4938706.NQELE8A71r@wasted.cogentembedded.com>
References: <4938706.NQELE8A71r@wasted.cogentembedded.com>
Message-ID: <1759135.UUeR1nn4JC@wasted.cogentembedded.com>
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
