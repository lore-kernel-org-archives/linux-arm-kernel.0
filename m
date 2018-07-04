From: mars.cheng@mediatek.com (Mars Cheng)
Date: Wed, 4 Jul 2018 09:52:53 +0800
Subject: [PATCH v3 3/4] dt-bindings: interrupt-controller: add binding for
 mt6765
In-Reply-To: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1530669174-17623-4-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the dt-binding documentation of sysirq for mt6765

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 07bf0b9..c8eda80 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -11,6 +11,7 @@ Required properties:
 	"mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
 	"mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
 	"mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq": for MT6797
+	"mediatek,mt6765-sysirq", "mediatek,mt6577-sysirq": for MT6765
 	"mediatek,mt6755-sysirq", "mediatek,mt6577-sysirq": for MT6755
 	"mediatek,mt6592-sysirq", "mediatek,mt6577-sysirq": for MT6592
 	"mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq": for MT6589
-- 
1.7.9.5
