From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 1 Jun 2017 02:44:13 +0800
Subject: [PATCH 1/4] dt-bindings: rng: add generic bindings for MediaTek SoCs
In-Reply-To: <cover.1496255334.git.sean.wang@mediatek.com>
References: <cover.1496255334.git.sean.wang@mediatek.com>
Message-ID: <1d9c981e1b45bf2f04732a02d90e6857cc203ce5.1496255334.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add the generic binding for allowing the support of RNG on MediaTek SoCs
such as MT7622.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/rng/mtk-rng.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
index a6d62a2..0772913 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
@@ -2,7 +2,8 @@ Device-Tree bindings for Mediatek random number generator
 found in Mediatek SoC family
 
 Required properties:
-- compatible	    : Should be "mediatek,mt7623-rng"
+- compatible	    : Should be "mediatek,generic-rng" or
+				"mediatek,mt7623-rng".
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
 - clock-names	    : Should contain "rng" entries;
-- 
1.9.1
