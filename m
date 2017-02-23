From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 23 Feb 2017 17:45:48 +0100
Subject: [PATCH v2 1/5] dt-bindings: Add vendor prefix for Zidoo
In-Reply-To: <20170223164553.3715-1-afaerber@suse.de>
References: <20170223164553.3715-1-afaerber@suse.de>
Message-ID: <20170223164553.3715-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zidoo is a Chinese manufacturer of TV boxes.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Roc He <hepeng@zidoo.tv>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Changed subject
 * Extended commit message
 
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a76b981..2776651 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -343,6 +343,7 @@ xlnx	Xilinx
 xunlong	Shenzhen Xunlong Software CO.,Limited
 zarlink	Zarlink Semiconductor
 zeitec	ZEITEC Semiconductor Co., LTD.
+zidoo	Shenzhen Zidoo Technology Co., Ltd.
 zii	Zodiac Inflight Innovations
 zte	ZTE Corp.
 zyxel	ZyXEL Communications Corp.
-- 
2.10.2
