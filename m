From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 13 Mar 2014 17:24:33 -0300
Subject: [PATCH v3 6/6] clk: mvebu: Update binding documentation for the core
 divider clock
In-Reply-To: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394742273-5113-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Core Divider clock support two new compatible strings for Armada
375 and Armada 380 SoCs. Add the compatible strings to the documentation.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
index c62391f..520562a 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
@@ -4,7 +4,10 @@ The following is a list of provided IDs and clock names on Armada 370/XP:
  0 = nand (NAND clock)
 
 Required properties:
-- compatible : must be "marvell,armada-370-corediv-clock"
+- compatible : must be "marvell,armada-370-corediv-clock",
+		       "marvell,armada-375-corediv-clock",
+		       "marvell,armada-380-corediv-clock",
+
 - reg : must be the register address of Core Divider control register
 - #clock-cells : from common clock binding; shall be set to 1
 - clocks : must be set to the parent's phandle
-- 
1.9.0
