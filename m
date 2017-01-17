From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Jan 2017 23:54:58 +0100
Subject: [PATCH 2/3] Documentation: devicetree: amlogic: Add R-Box Pro
In-Reply-To: <20170117225459.4438-1-afaerber@suse.de>
References: <20170117030611.23827-2-afaerber@suse.de>
 <20170117225459.4438-1-afaerber@suse.de>
Message-ID: <20170117225459.4438-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: ada at kingnoval.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Originally I thought we would group by SoC (6, 8, 8b, gxbb, gxl, gmx, etc.)
 but this got out of order with nexbox,a95x - so inserting kingnovel between
 amlogic and nexbox here. If that's what we want going forward, we should move
 the old entries to make the scheme clearer. The alternative would be to
 reorder alphabetically within each SoC group, but nexbox,a95x with two SoCs
 makes it difficult to categorize, we could choose gxbb as the earlier one.
 
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 9b2b41ab6817..fb0ee7d9a921 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -45,5 +45,6 @@ Board compatible values:
   - "amlogic,p231" (Meson gxl s905d)
   - "amlogic,q200" (Meson gxm s912)
   - "amlogic,q201" (Meson gxm s912)
+  - "kingnovel,r-box-pro" (Meson gxm S912)
   - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
   - "nexbox,a1" (Meson gxm s912)
-- 
2.10.2
