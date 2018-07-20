From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 20 Jul 2018 13:12:30 +0800
Subject: [PATCH v6 4/4] MAINTAINERS: add an entry for MediaTek Bluetooth driver
In-Reply-To: <cover.1532060309.git.sean.wang@mediatek.com>
References: <cover.1532060309.git.sean.wang@mediatek.com>
Message-ID: <28888e6b95eb1dee15d9b841714a6eafcabe5252.1532060309.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek Bluetooth driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20de9a5..5d81cc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8780,6 +8780,14 @@ F:	include/uapi/linux/meye.h
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
