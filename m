From: carlo@caione.org (Carlo Caione)
Date: Sat,  4 Mar 2017 21:26:23 +0100
Subject: [PATCH v3 1/2] dt-bindings: amlogic: Add HwaCom board
In-Reply-To: <20170304202624.29682-1-carlo@caione.org>
References: <20170304202624.29682-1-carlo@caione.org>
Message-ID: <20170304202624.29682-2-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index c246cd2730d9..b3241a6802f6 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -45,6 +45,7 @@ Board compatible values:
   - "amlogic,p212" (Meson gxl s905x)
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
+  - "hwacom,amazetv" (Meson gxl s905x)
   - "amlogic,q200" (Meson gxm s912)
   - "amlogic,q201" (Meson gxm s912)
   - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
-- 
2.12.0
