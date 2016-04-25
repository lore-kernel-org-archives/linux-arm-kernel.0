From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:27:35 +1000
Subject: [PATCH 17/22] ARM: dts: r8a7790: Set maximum frequencies for SDHI
 clocks
In-Reply-To: <cover.1461558315.git.horms+renesas@verge.net.au>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
Message-ID: <22f708b057dbe3ab4aa53c76b5f3051743784777.1461558315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Taken from the datasheet.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7486fcf985c4..b920facb0c3b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -589,6 +589,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
+		max-frequency = <156000000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -600,6 +601,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
+		max-frequency = <156000000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -611,6 +613,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -622,6 +625,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.7.0.rc3.207.g0ac5344
