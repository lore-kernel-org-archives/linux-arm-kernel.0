From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 12 Jun 2017 23:56:54 +0800
Subject: [PATCH v2 1/3] dt-bindings: rng: add MediaTek MT7622 Hardware Random
 Generator bindings
In-Reply-To: <cover.1497280813.git.sean.wang@mediatek.com>
References: <cover.1497280813.git.sean.wang@mediatek.com>
Message-ID: <89b9b682ff9e294df7cda75787c1439c95ffc992.1497280813.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Document the bindings used by MediaTek MT7622 SoC hardware random number
generator.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/rng/mtk-rng.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
index a6d62a2..366b99b 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
@@ -2,7 +2,9 @@ Device-Tree bindings for Mediatek random number generator
 found in Mediatek SoC family
 
 Required properties:
-- compatible	    : Should be "mediatek,mt7623-rng"
+- compatible	    : Should be
+			"mediatek,mt7622-rng", 	"mediatek,mt7623-rng" : for MT7622
+			"mediatek,mt7623-rng" : for MT7623
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
 - clock-names	    : Should contain "rng" entries;
-- 
1.9.1
