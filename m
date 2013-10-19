From: leigh@solinno.co.uk (Leigh Brown)
Date: Sat, 19 Oct 2013 17:23:54 +0100
Subject: [PATCH RFC 4/4] net: mvmdio: doc: mvmdio now used by mv643xx_eth
In-Reply-To: <cover.1382199042.git.leigh@solinno.co.uk>
References: <cover.1382199042.git.leigh@solinno.co.uk>
Message-ID: <68de0618e58ac3e5b4314130c3abbe331d298351.1382199042.git.leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amend the documentation in the mvmdio driver to note the fact
that it is now used by both the mvneta and mv643xx_eth drivers.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 3992e2b..51af2e1 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -4,11 +4,9 @@
  * Since the MDIO interface of Marvell network interfaces is shared
  * between all network interfaces, having a single driver allows to
  * handle concurrent accesses properly (you may have four Ethernet
- * ports, but they in fact share the same SMI interface to access the
- * MDIO bus). Moreover, this MDIO interface code is similar between
- * the mv643xx_eth driver and the mvneta driver. For now, it is only
- * used by the mvneta driver, but it could later be used by the
- * mv643xx_eth driver as well.
+ * ports, but they in fact share the same SMI interface to access
+ * the MDIO bus). This driver is currently used by the mvneta and 
+ * mv643xx_eth drivers.
  *
  * Copyright (C) 2012 Marvell
  *
-- 
1.7.10.4
