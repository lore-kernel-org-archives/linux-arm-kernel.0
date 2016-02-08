From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  8 Feb 2016 03:17:38 +0100
Subject: [PATCH v2 09/10] Documentation: devicetree: rockchip: Document
 Landingship
In-Reply-To: <1454897859-7601-1-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
Message-ID: <1454897859-7601-10-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "geekbuying,landingship" compatible string, plus those of GeekBox.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 Documentation/devicetree/bindings/arm/rockchip.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index f633595b196c..c6d95f202591 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -91,6 +91,11 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "geekbuying,geekbox", "rockchip,rk3368";
 
+- GeekBuying Landingship:
+    Required root node properties:
+      - compatible = "geekbuying,landingship",
+		     "geekbuying,geekbox", "rockchip,rk3368";
+
 - Rockchip RK3368 evb:
     Required root node properties:
       - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";
-- 
2.6.2
