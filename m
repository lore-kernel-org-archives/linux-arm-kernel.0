From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 29 Jun 2018 10:20:31 +0800
Subject: [PATCH 5/5] MAINTAINERS: update files of MediaTek USB3 PHYs
In-Reply-To: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
References: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
Message-ID: <d5e0fb3a6ed54f974c303ed307cdfed7b7263c04.1530238400.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update maintained files include MediaTek USB3 PHYs drivers and
their bindings

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..2b782f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1647,7 +1647,8 @@ M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/phy/mediatek/phy-mtk-tphy.c
+F:	drivers/phy/mediatek/
+F:	Documentation/devicetree/bindings/phy/phy-mtk-*
 
 ARM/MICREL KS8695 ARCHITECTURE
 M:	Greg Ungerer <gerg@uclinux.org>
-- 
1.9.1
