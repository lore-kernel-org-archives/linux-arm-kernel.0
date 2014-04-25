From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 26 Apr 2014 02:51:27 +0400
Subject: [PATCH] ARM: shmobile: henninger: enable SATA0
Message-ID: <201404260251.28274.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SATA0 device for the Henninger board. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.15-rc2-20140425v2' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-henninger.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -74,3 +74,7 @@
 		micrel,led-mode = <1>;
 	};
 };
+
+&sata0 {
+       status = "okay";
+};
