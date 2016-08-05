From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 06 Aug 2016 00:52:39 +0300
Subject: [PATCH] ARM: dts: r8a7792: fix misindented line
In-Reply-To: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
References: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
Message-ID: <4152284.qHAgBjWaW0@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2a0900655d5e (ARM: dts: r8a7792: add I2C support) had a wrongly
indented line at the end of the "aliases" subnode -- fix it.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160725-v4.7-rc7' tag of Simon
Horman's 'renesas.git' repo.

 arch/arm/boot/dts/r8a7792.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -31,7 +31,7 @@
 		vin3 = &vin3;
 		vin4 = &vin4;
 		vin5 = &vin5;
-};
+	};
 
 	cpus {
 		#address-cells = <1>;
