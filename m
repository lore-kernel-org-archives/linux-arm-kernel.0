From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 14 Apr 2014 13:02:47 +0900
Subject: [PATCH] ARM: shmobile: lager: correct renesas, gpios to renesas,
 groups in sd[02] pfc
In-Reply-To: <cover.1397448066.git.horms+renesas@verge.net.au>
References: <cover.1397448066.git.horms+renesas@verge.net.au>
Message-ID: <b08eed0c4d7d70eae2f4f1ff518cc33643722a07.1397448066.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Taylor <rob.taylor@codethink.co.uk>

Fix probable typo of renesas,groups in the lager dt. The kernel has no
renesas,gpios but this should match renesas,groups.

Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
[ben.dooks at codethink.co.uk: fixup description]
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6e99eb2..d01048a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -141,12 +141,12 @@
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,gpios = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
 		renesas,function = "sdhi0";
 	};
 
 	sdhi2_pins: sd2 {
-		renesas,gpios = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
 
-- 
1.8.5.2
