From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 17:23:11 +0200
Subject: [PATCH v2 2/3] dt-bindings: arm: amlogic: Add R-Box Pro
In-Reply-To: <20170513152312.19912-1-afaerber@suse.de>
References: <20170513152312.19912-1-afaerber@suse.de>
Message-ID: <20170513152312.19912-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: ada at kingnoval.com
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Rebased onto my cleanup series
 * Tweaked subject
 
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index cad5b5a48d92..7f05978791c1 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -57,4 +57,5 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "amlogic,q200" (Meson gxm s912)
   - "amlogic,q201" (Meson gxm s912)
+  - "kingnovel,r-box-pro" (Meson gxm S912)
   - "nexbox,a1" (Meson gxm s912)
-- 
2.12.0
