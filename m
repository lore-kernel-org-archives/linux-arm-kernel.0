From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 15 Mar 2018 15:40:37 +0800
Subject: [PATCH v7 3/3] dmaengine: mediatek: update MAINTAINERS entry with
 MediaTek DMA driver
In-Reply-To: <cover.1521098171.git.sean.wang@mediatek.com>
References: <cover.1521098171.git.sean.wang@mediatek.com>
Message-ID: <d63a1d2ca458fd74d5ca188d44b753aa234dd738.1521098171.git.sean.wang@mediatek.com>
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
index 3bdc260..d3c33d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8785,6 +8785,15 @@ M:	Sean Wang <sean.wang@mediatek.com>
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
