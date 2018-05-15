From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 15 May 2018 16:52:22 +0800
Subject: [PATCH v2 7/7] MAINTAINERS: add an entry for MediaTek Bluetooth driver
In-Reply-To: <cover.1526374087.git.sean.wang@mediatek.com>
References: <cover.1526374087.git.sean.wang@mediatek.com>
Message-ID: <62c9f6e3d334769f1b338d8cd4c0763ec0102ca3.1526374087.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek Bluetooth driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d..3e9fa7c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8874,6 +8874,14 @@ F:	include/uapi/linux/meye.h
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
