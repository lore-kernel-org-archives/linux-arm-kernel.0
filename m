From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 1 Aug 2018 01:15:00 +0800
Subject: [PATCH v7 3/3] MAINTAINERS: add an entry for MediaTek Bluetooth driver
In-Reply-To: <cover.1533056925.git.sean.wang@mediatek.com>
References: <cover.1533056925.git.sean.wang@mediatek.com>
Message-ID: <2d2207cea603862ba6a7195806cb4b4ebc43fd17.1533056925.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek Bluetooth driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f2cce4..e983d9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9144,6 +9144,14 @@ F:	include/uapi/linux/meye.h
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
