From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 21 May 2018 01:01:52 +0800
Subject: [PATCH v1 6/7] MAINTAINERS: update entry for PIN CONTROLLER - MEDIATEK
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
Message-ID: <e5bcfc9671a79fef4f38933bb04894f0f53b3d63.1526835466.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add new files for the entry

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9051a9c..7f3cced 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11193,6 +11193,7 @@ L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
+F:	drivers/pinctrl/mediatek/mtk-eint.*
 F:	drivers/pinctrl/mediatek/pinctrl-mtk-common.*
 F:	drivers/pinctrl/mediatek/pinctrl-mt2701.c
 F:	drivers/pinctrl/mediatek/pinctrl-mt7622.c
-- 
2.7.4
