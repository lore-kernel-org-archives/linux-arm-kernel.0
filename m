From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  9 Apr 2014 15:51:04 +0200
Subject: [PATCH 01/15] ARM: sunxi: dt: list all pinctrl compatible strings
In-Reply-To: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397051478-4113-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List all sunxi pinctrl compatible strings in order to be able to grep for
those values.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index dff0e5f..0e7e9a1 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -6,8 +6,13 @@ the first two functions being GPIO in and out. The configuration on
 the pins includes drive strength and pull-up.
 
 Required properties:
-- compatible: "allwinner,<soc>-pinctrl". Supported SoCs for now are:
-  sun5i-a13.
+- compatible: Should be one of the followings (depending on you SoC):
+  "allwinner,sun4i-a10-pinctrl"
+  "allwinner,sun5i-a10s-pinctrl"
+  "allwinner,sun5i-a13-pinctrl"
+  "allwinner,sun6i-a31-pinctrl"
+  "allwinner,sun6i-a31-pinctrl"
+  "allwinner,sun7i-a20-pinctrl"
 - reg: Should contain the register physical address and length for the
   pin controller.
 
-- 
1.8.3.2
