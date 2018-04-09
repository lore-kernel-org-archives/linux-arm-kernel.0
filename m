From: eric@anholt.net (Eric Anholt)
Date: Mon,  9 Apr 2018 16:00:39 -0700
Subject: [PATCH 2/3] ARM: dts: bcm283x: Remove the vc4 GPU subsystem node.
In-Reply-To: <20180409230040.1100-1-eric@anholt.net>
References: <20180409230040.1100-1-eric@anholt.net>
Message-ID: <20180409230040.1100-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer required by the DRM driver, and was just a temporary
hack for it.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9d293decf8d3..869bf350d426 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -609,10 +609,6 @@
 			reg = <0x7ec00000 0x1000>;
 			interrupts = <1 10>;
 		};
-
-		vc4: gpu {
-			compatible = "brcm,bcm2835-vc4";
-		};
 	};
 
 	clocks {
-- 
2.17.0
