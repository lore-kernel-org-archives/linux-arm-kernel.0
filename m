From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:49 +0900
Subject: [PATCH 19/25] ARM: shmobile: r8a7791: dtsi: add internal delay for
 i2c IPs
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <49160dc19fcfa00c0d0901853aac49df87228915.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 36559cb0eb6b..3a2551094b8b 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -407,6 +407,7 @@
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -418,6 +419,7 @@
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -429,6 +431,7 @@
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -440,6 +443,7 @@
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -451,6 +455,7 @@
 		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -463,6 +468,7 @@
 		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
 
-- 
2.1.4
