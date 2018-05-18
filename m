From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:50 +0200
Subject: [PATCH 17/69] ARM: dts: r8a7745: Adjust SMP routine size
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <7270dedc8438c7247474a33a8334f3920816e2c2.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adjusts the definition of the SMP routine size according
to the latest changes made by commit:
"ARM: shmobile: Add watchdog support"

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index dd49a8b48f3e..0c3f4c5b345b 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -360,7 +360,7 @@
 
 			smp-sram at 0 {
 				compatible = "renesas,smp-sram";
-				reg = <0 0x10>;
+				reg = <0 0x100>;
 			};
 		};
 
-- 
2.11.0
