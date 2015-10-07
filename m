From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 08 Oct 2015 01:00:06 +0300
Subject: [PATCH] ARM: shmobile: porter: enable SATA0
Message-ID: <2739743.SVEuIvyJ6z@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SATA0 device for the Porter board.

This patch is analogous to the commit 5a62ec57004f ("ARM: shmobile:
henninger: enable SATA0") as there are no differences between the boards
in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151007-v4.3-rc4' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -154,3 +154,7 @@
 	cd-gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&sata0 {
+	status = "okay";
+};
