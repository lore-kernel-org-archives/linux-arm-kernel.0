From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:50 +0900
Subject: [PATCH 20/25] ARM: shmobile: r8a7794: dtsi: add internal delay for
 i2c IPs
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <691cd0a64d9215a838a7351de890d815b9a2622e.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 89e914f2a2cf..7fb2da2f54ff 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -518,6 +518,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -529,6 +530,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -540,6 +542,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -551,6 +554,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -562,6 +566,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -573,6 +578,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
-- 
2.1.4
