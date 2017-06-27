From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 27 Jun 2017 02:55:15 +0200
Subject: [PATCH 1/6] dt-bindings: Add RDA Micro vendor prefix
In-Reply-To: <20170627005520.23731-1-afaerber@suse.de>
References: <20170627005520.23731-1-afaerber@suse.de>
Message-ID: <20170627005520.23731-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RDA Microelectronics is a Chinese SoC manufacturer.

Cc: service at rdamicro.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index afbb47ce50dd..c54c1e069516 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -270,6 +270,7 @@ ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 raspberrypi	Raspberry Pi Foundation
 raydium	Raydium Semiconductor Corp.
+rda	RDA Microelectronics, Inc.
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
 richtek	Richtek Technology Corporation
-- 
2.12.3
