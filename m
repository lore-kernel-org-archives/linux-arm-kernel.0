From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:41 +0900
Subject: [PATCH 13/33] ARM: shmobile: lager: Set ethernet PHY LED mode
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <f17dd09d5133bc0705c8319df77169cb8491eaad.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The Lager board uses the ethernet PHY LED0 as a link signal connected to
the ethernet controller. Specify the corresponding LED mode for the PHY.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index c3d8b17..a55c5f8 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -213,6 +213,7 @@
 		reg = <1>;
 		interrupt-parent = <&irqc0>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		led-mode = <1>;
 	};
 };
 
-- 
1.8.5.2
