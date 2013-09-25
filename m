From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 25 Sep 2013 16:10:18 -0300
Subject: [PATCH] clk: fixed-factor: Fix device-tree binding typo
Message-ID: <1380136218-15578-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The required properties are not named "div" and "mult",
but rather "clock-div" and "clock-mult".

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/fixed-factor-clock.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
index 5757f9a..1bae8527 100644
--- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
@@ -19,6 +19,6 @@ Example:
 		compatible = "fixed-factor-clock";
 		clocks = <&parentclk>;
 		#clock-cells = <0>;
-		div = <2>;
-		mult = <1>;
+		clock-div = <2>;
+		clock-mult = <1>;
 	};
-- 
1.8.1.5
