From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Sep 2016 12:04:54 +0200
Subject: [PATCH] ARM: dts: gose: use generic pinctrl properties in SDHI nodes
Message-ID: <1474020294-1544-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 90af18600124..dc311eba4444 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -346,18 +346,18 @@
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
 	};
 
 	sdhi1_pins: sd1 {
-		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
-		renesas,function = "sdhi1";
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
 	};
 
 	sdhi2_pins: sd2 {
-		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
-		renesas,function = "sdhi2";
+		groups = "sdhi2_data4", "sdhi2_ctrl";
+		function = "sdhi2";
 	};
 
 	qspi_pins: qspi {
-- 
2.7.0.rc3.207.g0ac5344
