From: john@metanate.com (John Keeping)
Date: Thu,  1 Mar 2018 10:34:47 +0000
Subject: [PATCH] dt-bindings: rockchip-dw-mshc: use consistent clock names
Message-ID: <20180301103447.7059-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The names of these clocks are "ciu-drive" and "ciu-sample" as described
for the clock-names property.  Avoid confusion by spelling these
correctly everywhere they are referenced.

Signed-off-by: John Keeping <john@metanate.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index c6558785e61b..8ce49b255974 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -21,7 +21,7 @@ Required Properties:
 	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
 
 Optional Properties:
-* clocks: from common clock binding: if ciu_drive and ciu_sample are
+* clocks: from common clock binding: if ciu-drive and ciu-sample are
   specified in clock-names, should contain handles to these clocks.
 
 * clock-names: Apart from the clock-names described in synopsys-dw-mshc.txt
@@ -29,7 +29,7 @@ Optional Properties:
   to control the clock phases, "ciu-sample" is required for tuning high-
   speed modes.
 
-* rockchip,default-sample-phase: The default phase to set ciu_sample at
+* rockchip,default-sample-phase: The default phase to set ciu-sample at
   probing, low speeds or in case where all phases work at tuning time.
   If not specified 0 deg will be used.
 
-- 
2.16.2
