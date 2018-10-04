From: marex@denx.de (Marek Vasut)
Date: Fri,  5 Oct 2018 00:42:26 +0200
Subject: [PATCH 1/2] of: Add vendor prefix for Menlo Systems GmbH
Message-ID: <20181004224227.16836-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vendor prefix for Menlo Systems GmbH, http://www.menlosystems.com/ .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4cf887bac4ac..2bf470e06a15 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -233,6 +233,7 @@ melexis	Melexis N.V.
 melfas	MELFAS Inc.
 mellanox	Mellanox Technologies
 memsic	MEMSIC Inc.
+menlo	Menlo Systems GmbH
 merrii	Merrii Technology Co., Ltd.
 micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
-- 
2.18.0
