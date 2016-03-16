From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Mar 2016 14:58:41 +0100
Subject: [PATCH v4 3/8] Documentation: devicetree: rockchip: Document GeekBox
In-Reply-To: <1458136727-32075-1-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
Message-ID: <1458136727-32075-4-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "geekbuying,geekbox" compatible string.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v2 -> v3: Unchanged

 v2: New (Heiko)
 
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 078c14fcdaaa..f633595b196c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -87,6 +87,10 @@ Rockchip platforms device tree bindings
 		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
 		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
 
+- GeekBuying GeekBox:
+    Required root node properties:
+      - compatible = "geekbuying,geekbox", "rockchip,rk3368";
+
 - Rockchip RK3368 evb:
     Required root node properties:
       - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";
-- 
2.6.2
