From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Feb 2014 18:32:45 +0100
Subject: [PATCH 2/6] dt: Update binding information for mvebu core clocks with
 Armada 375
In-Reply-To: <1392053569-28037-1-git-send-email-gregory.clement@free-electrons.com>
References: <1392053569-28037-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1392053569-28037-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the binding information for the core clocks of the Armada 375 SoCs

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index 1e662948661e..62fc34a1506d 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -11,6 +11,12 @@ The following is a list of provided IDs and clock names on Armada 370/XP:
  3 = hclk    (DRAM control clock)
  4 = dramclk (DDR clock)
 
+The following is a list of provided IDs and clock names on Armada 375:
+ 0 = tclk    (Internal Bus clock)
+ 1 = cpuclk  (CPU clock)
+ 2 = l2clk   (L2 Cache clock)
+ 3 = ddrclk  (DDR clock)
+
 The following is a list of provided IDs and clock names on Kirkwood and Dove:
  0 = tclk   (Internal Bus clock)
  1 = cpuclk (CPU0 clock)
@@ -20,6 +26,7 @@ The following is a list of provided IDs and clock names on Kirkwood and Dove:
 Required properties:
 - compatible : shall be one of the following:
 	"marvell,armada-370-core-clock" - For Armada 370 SoC core clocks
+	"marvell,armada-375-core-clock" - For Armada 375 SoC core clocks
 	"marvell,armada-xp-core-clock" - For Armada XP SoC core clocks
 	"marvell,dove-core-clock" - for Dove SoC core clocks
 	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
-- 
1.8.1.2
