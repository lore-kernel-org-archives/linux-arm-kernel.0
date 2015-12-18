From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:42:39 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7794: use fallback pci compatibility
 string
In-Reply-To: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
References: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1450406559-9076-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7794 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6c78f1fae90f..94ef03ad9cc3 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -654,7 +654,7 @@
 	};
 
 	pci0: pci at ee090000 {
-		compatible = "renesas,pci-r8a7794";
+		compatible = "renesas,pci-r8a7794", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
@@ -689,7 +689,7 @@
 	};
 
 	pci1: pci at ee0d0000 {
-		compatible = "renesas,pci-r8a7794";
+		compatible = "renesas,pci-r8a7794", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
-- 
2.1.4
