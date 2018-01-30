From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 30 Jan 2018 20:22:39 +0000
Subject: [RFC v3 06/25] ARM: dts: r8a7792: Adjust SMP routine size
In-Reply-To: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1517343778-27902-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adjusts the definition of the SMP routine size according
to the latest changes made by commit:
"ARM: shmobile: Add watchdog support"

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v1->v3:
* increased size to 0x100

 arch/arm/boot/dts/r8a7792.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 268987f..bea0f12 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -341,7 +341,7 @@
 
 			smp-sram at 0 {
 				compatible = "renesas,smp-sram";
-				reg = <0 0x10>;
+				reg = <0 0x100>;
 			};
 		};
 
-- 
2.7.4
