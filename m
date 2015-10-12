From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 12 Oct 2015 10:41:57 +0800
Subject: [PATCH] MAINTAINERS: add Mediatek usb3 phy driver
Message-ID: <1444617717-13706-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mediatek usb3 phy driver to maintainer entry.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab7..be0055c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1291,6 +1291,13 @@ F:	arch/arm/mach-mediatek/
 N:	mtk
 K:	mediatek
 
+ARM/Mediatek USB3 PHY DRIVER
+M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/phy/phy-mt65xx-usb3.c
+
 ARM/MICREL KS8695 ARCHITECTURE
 M:	Greg Ungerer <gerg@uclinux.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.8.1.1.dirty
