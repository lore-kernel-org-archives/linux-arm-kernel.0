From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 22 Nov 2018 22:04:18 +0100
Subject: [PATCH 4/6] MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
In-Reply-To: <20181122210420.14861-1-miquel.raynal@bootlin.com>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
Message-ID: <20181122210420.14861-5-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as Armada 3700 COMPHY driver/bindings maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..a1d6457cccb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8864,6 +8864,12 @@ F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
 
+MARVELL ARMADA 3700 COMPHY DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+
 MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <boris.brezillon@bootlin.com>
 M:	Arnaud Ebalard <arno@natisbad.org>
-- 
2.19.1
