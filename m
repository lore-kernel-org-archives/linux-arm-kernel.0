From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 27 Sep 2014 01:10:46 +0400
Subject: [PATCH v4 3/3] ARM: shmobile: henninger: enable USB PHY
In-Reply-To: <3383603.zZsCVpCDbD@wasted.cogentembedded.com>
References: <3383603.zZsCVpCDbD@wasted.cogentembedded.com>
Message-ID: <19100173.2CvJq460O8@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB PHY device for the Henninger board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- refreshed the patch.

Changes in version 3:
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-henninger.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -271,6 +271,10 @@
 	pinctrl-names = "default";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &pcie_bus_clk {
 	status = "okay";
 };
