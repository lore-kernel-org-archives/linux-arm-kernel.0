From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:32:13 +0900
Subject: [PATCH 5/5] ARM: shmobile: koelsch: correct renesas, gpios to renesas,
 groups in sd[012] pfc
In-Reply-To: <cover.1397694064.git.horms+renesas@verge.net.au>
References: <cover.1397694064.git.horms+renesas@verge.net.au>
Message-ID: <d5dda0381f826326071b027f288372f682c24d55.1397694064.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Fix typo of renesas,groups in the koeslch dt. The kernel has no
renesas,gpios but this should match renesas,groups.

Noticed thanks to similar fix for Lager by Rob Taylor and Ben Dooks.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index bdd73e6..de1b697 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -230,17 +230,17 @@
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,gpios = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
 		renesas,function = "sdhi0";
 	};
 
 	sdhi1_pins: sd1 {
-		renesas,gpios = "sdhi1_data4", "sdhi1_ctrl";
+		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
 		renesas,function = "sdhi1";
 	};
 
 	sdhi2_pins: sd2 {
-		renesas,gpios = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
 
-- 
1.8.4
