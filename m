From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:00 +0900
Subject: [PATCH 26/69] ARM: shmobile: kzm9g: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <26adf1a79e847ac147c1cc9f2c033ff5e4a73e22.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 8ee06dd..df75aea 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -205,7 +205,7 @@
 		renesas,function = "i2c3";
 	};
 
-	mmcif_pins: mmcif {
+	mmcif_pins: mmc {
 		mux {
 			renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
 			renesas,function = "mmc0";
@@ -217,17 +217,17 @@
 		};
 	};
 
-	scifa4_pins: scifa4 {
+	scifa4_pins: serial4 {
 		renesas,groups = "scifa4_data", "scifa4_ctrl";
 		renesas,function = "scifa4";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
 
-	sdhi2_pins: sdhi2 {
+	sdhi2_pins: sd2 {
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
-- 
1.8.4
