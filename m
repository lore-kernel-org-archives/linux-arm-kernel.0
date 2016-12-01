From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Dec 2016 10:07:26 +0100
Subject: [PATCH] arm64: dts: h3ulcb: Provide sd0_uhs node
Message-ID: <1480583246-6707-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide separaate sd0 and sd0_uhs nodes rather than duplicate sd0 nodes.

Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Fixes: 93373c309a70 ("arm64: dts: h3ulcb: rename SDHI0 pins")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index 6ffb0517421a..dbea2c3d8f0c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -169,7 +169,7 @@
 		power-source = <3300>;
 	};
 
-	sdhi0_pins_uhs: sd0 {
+	sdhi0_pins_uhs: sd0_uhs {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
 		power-source = <1800>;
-- 
2.7.0.rc3.207.g0ac5344
