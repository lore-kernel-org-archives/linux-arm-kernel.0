From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 14 May 2017 04:24:25 +0200
Subject: [PATCH v3 1/5] dt-bindings: Add vendor prefix for Zidoo
In-Reply-To: <20170514022429.11555-1-afaerber@suse.de>
References: <20170514022429.11555-1-afaerber@suse.de>
Message-ID: <20170514022429.11555-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zidoo is a Chinese manufacturer of TV boxes.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Roc He <hepeng@zidoo.tv>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3: unchanged
 
 v1 -> v2:
 * Changed subject
 * Extended commit message
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c03d20140366..f032fa69f9d1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -356,6 +356,7 @@ xlnx	Xilinx
 xunlong	Shenzhen Xunlong Software CO.,Limited
 zarlink	Zarlink Semiconductor
 zeitec	ZEITEC Semiconductor Co., LTD.
+zidoo	Shenzhen Zidoo Technology Co., Ltd.
 zii	Zodiac Inflight Innovations
 zte	ZTE Corp.
 zyxel	ZyXEL Communications Corp.
-- 
2.12.0
