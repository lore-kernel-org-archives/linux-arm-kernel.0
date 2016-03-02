From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  2 Mar 2016 03:35:00 +0100
Subject: [PATCH v2 5/6] Documentation: devicetree: amlogic: Document Tronsmart
 Vega S95 boards
In-Reply-To: <1456886101-22967-1-git-send-email-afaerber@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
Message-ID: <1456886101-22967-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "tronsmart,vega-s95" as well as
    "tronsmart,vega-s95-pro",
    "tronsmart,vega-s95-meta" and
    "tronsmart,vega-s95-telos" compatible strings.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: unchanged
 
 Documentation/devicetree/bindings/arm/amlogic.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 776f08ca215f..8a5122ab19b0 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -22,3 +22,6 @@ Board compatible values:
   - "minix,neo-x8" (Meson8)
   - "tronfy,mxq" (Meson8b)
   - "hardkernel,odroid-c1" (Meson8b)
+  - "tronsmart,vega-s95-pro", "tronsmart,vega-s95" (Meson gxbb)
+  - "tronsmart,vega-s95-meta", "tronsmart,vega-s95" (Meson gxbb)
+  - "tronsmart,vega-s95-telos", "tronsmart,vega-s95" (Meson gxbb)
-- 
2.6.2
