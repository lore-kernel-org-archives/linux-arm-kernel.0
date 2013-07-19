From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:37:01 +0900
Subject: [PATCH 07/19] ARM: shmobile: r8a7790: Add pin control device to
 device tree
In-Reply-To: <cover.1374208262.git.horms+renesas@verge.net.au>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
Message-ID: <2d6dcdb5352160d064cffefcd63368ad0d518860.1374208262.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a pfc node to the r8a7790 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 339d9b1..13caf12 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -54,4 +54,9 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
+
+	pfc: pfc at e6060000 {
+		compatible = "renesas,pfc-r8a7790";
+		reg = <0 0xe6060000 0 0x250>;
+	};
 };
-- 
1.7.10.4
