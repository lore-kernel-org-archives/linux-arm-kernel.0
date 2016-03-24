From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 24 Mar 2016 11:05:13 -0700
Subject: [PATCH v2 2/4] Documentation: devicetree: amlogic: Document P20x and
 ODROID-C2 boards
In-Reply-To: <1458842715-27066-1-git-send-email-khilman@baylibre.com>
References: <1458842715-27066-1-git-send-email-khilman@baylibre.com>
Message-ID: <1458842715-27066-3-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible strings for Amlogic S905/GXBB based boards: Hardkernel
ODROID-C2, Amlogic P200 and Amlogic P201.

Cc: devicetree at vger.kernel.org
Reviewed-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 8a5122ab19b0..fcc6f6c10803 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -25,3 +25,6 @@ Board compatible values:
   - "tronsmart,vega-s95-pro", "tronsmart,vega-s95" (Meson gxbb)
   - "tronsmart,vega-s95-meta", "tronsmart,vega-s95" (Meson gxbb)
   - "tronsmart,vega-s95-telos", "tronsmart,vega-s95" (Meson gxbb)
+  - "hardkernel,odroid-c2" (Meson gxbb)
+  - "amlogic,p200" (Meson gxbb)
+  - "amlogic,p201" (Meson gxbb)
-- 
2.7.4
