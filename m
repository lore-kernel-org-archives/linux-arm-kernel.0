From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:42 +0900
Subject: [PATCH 1/9] ARM: shmobile: Add r8a7740 Maximum CPU Frequency to DTS
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
Message-ID: <63575d8cd5cba0c657ac5c18f75e91e2e30cc0eb.1400200838.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add 800 MHz to the r8a7740 DTS to describe the maximum CPU frequency.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 8280884..67c4b8b 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -22,6 +22,7 @@
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0x0>;
+			clock-frequency = <800000000>;
 		};
 	};
 
-- 
1.8.5.2
