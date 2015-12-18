From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:15 +0900
Subject: [PATCH 07/10] arm64: renesas: r8a7795: add internal delay for i2c IPs
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
Message-ID: <9036a73087bc71d83f4efe4ed3d3b9548b1a0012.1450401186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b9229a49dabc..e14251164480 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -526,6 +526,7 @@
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -537,6 +538,7 @@
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
@@ -548,6 +550,7 @@
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
@@ -559,6 +562,7 @@
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -570,6 +574,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -581,6 +586,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -592,6 +598,7 @@
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-- 
2.1.4
