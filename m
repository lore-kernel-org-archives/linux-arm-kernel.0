From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 14 Dec 2012 17:45:26 +0100
Subject: [PATCH 2/7] ARM: mackerel: include the correct .dtsi file
In-Reply-To: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1355503531-7276-3-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mackerel's .dts Device Tree description file should derive from the SoC's
.dtsi, not from skeleton.dtsi directly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh7372-mackerel.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.2.5
