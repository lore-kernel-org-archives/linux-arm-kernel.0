From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 12:00:33 +0100
Subject: [PATCH 2/3] net: mvmdio: adjust multiline comment to net/ style
In-Reply-To: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353322834-16952-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by checkpatch, the multiline comments for net/ and
drivers/net/ have a slightly different format than the one used in the
rest of the kernel, so we adjust our multiline comment accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvmdio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 114a0f1..6d6002b 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -42,8 +42,7 @@ struct orion_mdio_dev {
 	void __iomem *smireg;
 };
 
-/*
- * Wait for the SMI unit to be ready for another operation
+/* Wait for the SMI unit to be ready for another operation
  */
 static int orion_mdio_wait_ready(struct mii_bus *bus)
 {
-- 
1.7.9.5
