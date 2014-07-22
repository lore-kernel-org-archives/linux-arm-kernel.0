From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 23 Jul 2014 01:28:12 +0400
Subject: [PATCH v3 3/3] ARM: shmobile: henninger: enable USB PHY
In-Reply-To: <201407230122.49264.sergei.shtylyov@cogentembedded.com>
References: <201407230122.49264.sergei.shtylyov@cogentembedded.com>
Message-ID: <201407230128.13836.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB PHY device for the Henninger board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-henninger.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -253,6 +253,10 @@
 	pinctrl-names = "default";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &pcie_bus_clk {
 	status = "okay";
 };
