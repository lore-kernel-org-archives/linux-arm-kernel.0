From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Mar 2016 14:58:45 +0100
Subject: [PATCH v4 7/8] Documentation: devicetree: rockchip: Document
 Landingship
In-Reply-To: <1458136727-32075-1-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
Message-ID: <1458136727-32075-8-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "geekbuying,geekbox-landingship" compatible string, plus those of
the GeekBox module.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v2 -> v3:
 * Changed compatible string to include geekbox- (Heiko)
   and clarify that this is for GeekBox module
 
 v2: New
 
 Documentation/devicetree/bindings/arm/rockchip.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index f633595b196c..ae84f4e1d83b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -91,6 +91,11 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "geekbuying,geekbox", "rockchip,rk3368";
 
+- GeekBuying Landingship with GeekBox module:
+    Required root node properties:
+      - compatible = "geekbuying,geekbox-landingship",
+		     "geekbuying,geekbox", "rockchip,rk3368";
+
 - Rockchip RK3368 evb:
     Required root node properties:
       - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";
-- 
2.6.2
