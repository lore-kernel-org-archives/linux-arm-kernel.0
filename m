From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:12 +0200
Subject: [PATCH 20/48] ARM: dts: gr-peach: Remove empty line
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <f7c68cdfebf6ad6b3c4d6b6c8966414219d035e3.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Remove an empty line in gr-peach device tree source file.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index a1b2aef984f6..1c40a1afbd8e 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -28,7 +28,6 @@
 	memory at 20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x00a00000>;
-
 	};
 
 	lbsc {
-- 
2.1.4
