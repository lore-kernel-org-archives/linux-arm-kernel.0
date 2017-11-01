From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:34:52 +0100
Subject: [PATCH v4 15/15] arm64: dts: renesas: r8a7795-es1: Enable IPMMU-MP1
In-Reply-To: <20171101103452.7491-1-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
Message-ID: <20171101103452.7491-16-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable the r8a7795 ES1.x device node for IPMMU-MP1.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v4 [Simon Horman]
* Broke out of larger patch

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index ae9334b25b31..78e990b7c6d1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -31,7 +31,6 @@
 		reg = <0 0xec680000 0 0x1000>; /* IPMMU-MP1 */
 		renesas,ipmmu-main = <&ipmmu_mm 5>;
 		#iommu-cells = <1>;
-		status = "disabled";
 	};
 
 	ipmmu_sy: mmu at e7730000 {
-- 
2.11.0
