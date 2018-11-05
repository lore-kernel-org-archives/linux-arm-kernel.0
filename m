From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Mon,  5 Nov 2018 11:45:07 +0100
Subject: [PATCH 1/2] dt-bindings: display: amlogic,
 meson-vpu: Add optional canvas provider node
In-Reply-To: <20181105104508.23090-1-mjourdan@baylibre.com>
References: <20181105104508.23090-1-mjourdan@baylibre.com>
Message-ID: <20181105104508.23090-2-mjourdan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows using the new canvas provider module if present.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
index 057b81335775..c65fd7a7467c 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
@@ -67,6 +67,8 @@ Required properties:
 Optional properties:
 - power-domains: Optional phandle to associated power domain as described in
 	the file ../power/power_domain.txt
+- amlogic,canvas: phandle to canvas provider node as described in the file
+	../soc/amlogic/amlogic,canvas.txt
 
 Required nodes:
 
-- 
2.19.1
