From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 27 Sep 2014 01:09:22 +0400
Subject: [PATCH v4 2/3] ARM: shmobile: koelsch: enable USB PHY
In-Reply-To: <3383603.zZsCVpCDbD@wasted.cogentembedded.com>
References: <3383603.zZsCVpCDbD@wasted.cogentembedded.com>
Message-ID: <2336627.VWjZqGPynz@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB PHY device for the Koelsch board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- refreshed the patch.

Changes in version 3:
- refreshed the patch.

Changes in version 2:
- fixed the wrong board name in the changelog;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-koelsch.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -463,6 +463,10 @@
 	pinctrl-names = "default";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &pcie_bus_clk {
 	status = "okay";
 };
