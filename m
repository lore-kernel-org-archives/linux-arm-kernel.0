From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 30 May 2014 18:56:03 +0200
Subject: [PATCH v6 5/6] dt-bindings: add documentation for Mediatek SoC
In-Reply-To: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
References: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1401468964-5307-6-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DT binding documentation for the MT6589 SoC from Mediatek.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../devicetree/bindings/arm/mediatek-mt65xx.txt    |    8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt b/Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt
new file mode 100644
index 0000000..d6ac71f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt
@@ -0,0 +1,8 @@
+Mediatek MT6589 Platforms Device Tree Bindings
+
+Boards with a SoC of the Mediatek MT6589 shall have the following property:
+
+Required root node property:
+
+compatible: must contain "mediatek,mt6589"
+
-- 
1.7.9.5
