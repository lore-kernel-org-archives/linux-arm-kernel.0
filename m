From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:17:27 +0900
Subject: [PATCH 1/7] ARM: mackerel: include the correct .dtsi file
In-Reply-To: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080253-30995-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Mackerel's .dts Device Tree description file should derive from the SoC's
.dtsi, not from skeleton.dtsi directly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/sh7372-mackerel.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh7372-mackerel.dts b/arch/arm/boot/dts/sh7372-mackerel.dts
index 286f0ca..2ede70d 100644
--- a/arch/arm/boot/dts/sh7372-mackerel.dts
+++ b/arch/arm/boot/dts/sh7372-mackerel.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "skeleton.dtsi"
+/include/ "sh7372.dtsi"
 
 / {
 	model = "Mackerel (AP4 EVM 2nd)";
-- 
1.7.10.4
