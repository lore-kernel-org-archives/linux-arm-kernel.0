From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:53 +0900
Subject: [PATCH 04/19] ARM: dts: r8a7791: use fallback pci compatibility string
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <d4809689e6cb5961d9673cdb2c0b54f0f9141f18.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 4456f54a5005..8910236e64bf 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1530,7 +1530,7 @@
 	};
 
 	pci0: pci at ee090000 {
-		compatible = "renesas,pci-r8a7791";
+		compatible = "renesas,pci-r8a7791", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
@@ -1565,7 +1565,7 @@
 	};
 
 	pci1: pci at ee0d0000 {
-		compatible = "renesas,pci-r8a7791";
+		compatible = "renesas,pci-r8a7791", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
-- 
2.7.0.rc3.207.g0ac5344
