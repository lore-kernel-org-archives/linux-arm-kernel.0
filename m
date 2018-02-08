From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 9 Feb 2018 01:58:49 +0800
Subject: [PATCH v4 3/5] dmaengine: mediatek: update MAINTAINERS entry with
 MediaTek DMA driver
In-Reply-To: <cover.1518110810.git.sean.wang@mediatek.com>
References: <cover.1518110810.git.sean.wang@mediatek.com>
Message-ID: <b2551734d0d6aefb9c6201884c470b9d643e10f1.1518110810.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

I work for MediaTek and maintain SoC targeting to home gateway and
also will keep extending and testing the function.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c90687e..48f85f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8786,6 +8786,15 @@ M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/media/rc/mtk-cir.c
 
+MEDIATEK DMA DRIVER
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	dmaengine at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/mtk-*
+F:	drivers/dma/mediatek/
+
 MEDIATEK PMIC LED DRIVER
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
-- 
2.7.4
