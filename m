From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:29 +0900
Subject: [PATCH 01/33] ARM: shmobile: Update r8a7791 CPU freq to 1500MHz in DTS
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <896b79df8d60c01d46be23c10cc0f1a6691cc588.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The correct maximum CPU frequency for r8a7791 is 1500 MHz
so update the r8a7791 SoC DTS to reflect this.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 4618170..23ae96e 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -37,14 +37,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
-			clock-frequency = <1300000000>;
+			clock-frequency = <1500000000>;
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
-			clock-frequency = <1300000000>;
+			clock-frequency = <1500000000>;
 		};
 	};
 
-- 
1.8.5.2
