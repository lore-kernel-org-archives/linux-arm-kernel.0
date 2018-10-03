From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed,  3 Oct 2018 11:09:11 +0200
Subject: [PATCH 3/4] [media] dt-bindings: mediatek: Add JPEG Decoder binding
 for MT7623
In-Reply-To: <20181003090912.30501-1-matthias.bgg@gmail.com>
References: <20181003090912.30501-1-matthias.bgg@gmail.com>
Message-ID: <20181003090912.30501-4-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a binding documentation for the JPEG Decoder of the
MT7623 SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../devicetree/bindings/media/mediatek-jpeg-decoder.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
index 3813947b4d4f..044b11913c49 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
@@ -5,6 +5,7 @@ Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
 Required properties:
 - compatible : must be one of the following string:
 	"mediatek,mt8173-jpgdec"
+	"mediatek,mt7623-jpgdec", "mediatek,mt2701-jpgdec"
 	"mediatek,mt2701-jpgdec"
 - reg : physical base address of the jpeg decoder registers and length of
   memory mapped region.
-- 
2.19.0
