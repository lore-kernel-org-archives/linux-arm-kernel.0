From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 17:17:26 +0100
Subject: [PATCH v2 2/6] MAINTAINERS: thermal: add entry for Marvell MVEBU
 thermal driver
In-Reply-To: <20181123161730.11289-1-miquel.raynal@bootlin.com>
References: <20181123161730.11289-1-miquel.raynal@bootlin.com>
Message-ID: <20181123161730.11289-3-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as Marvell MVEBU thermal driver maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..42028c06e4e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8902,6 +8902,11 @@ L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/marvell10g.c
 
+MARVELL MVEBU THERMAL DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	drivers/thermal/armada_thermal.c
+
 MARVELL MVNETA ETHERNET DRIVER
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	netdev at vger.kernel.org
-- 
2.19.1
