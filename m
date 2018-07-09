From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 9 Jul 2018 23:57:03 +0800
Subject: [PATCH v5 7/7] MAINTAINERS: add an entry for MediaTek Bluetooth driver
In-Reply-To: <cover.1531150733.git.sean.wang@mediatek.com>
References: <cover.1531150733.git.sean.wang@mediatek.com>
Message-ID: <12d1a2d1e533266e242f5912d8649908dceb231b.1531150733.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek Bluetooth driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ad887b..c3d5c2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9044,6 +9044,14 @@ F:	include/uapi/linux/meye.h
 F:	include/uapi/linux/ivtv*
 F:	include/uapi/linux/uvcvideo.h
 
+MEDIATEK BLUETOOTH DRIVER
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-bluetooth at vger.kernel.org
+L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+F:	drivers/bluetooth/btmtkuart.c
+
 MEDIATEK CIR DRIVER
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
-- 
2.7.4
