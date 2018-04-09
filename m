From: eric@anholt.net (Eric Anholt)
Date: Mon,  9 Apr 2018 16:00:40 -0700
Subject: [PATCH 3/3] ARM: dts: cygnus: Remove the vc4 GPU subsystem node.
In-Reply-To: <20180409230040.1100-1-eric@anholt.net>
References: <20180409230040.1100-1-eric@anholt.net>
Message-ID: <20180409230040.1100-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer required by the DRM driver, and was just a temporary
hack for it.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 699fdf94d139..258bb3d61582 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -492,10 +492,6 @@
 			status = "disabled";
 		};
 
-		vc4: gpu {
-			compatible = "brcm,cygnus-vc4";
-		};
-
 		gpio_asiu: gpio at 180a5000 {
 			compatible = "brcm,cygnus-asiu-gpio";
 			reg = <0x180a5000 0x668>;
-- 
2.17.0
