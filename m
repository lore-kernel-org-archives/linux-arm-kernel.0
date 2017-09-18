From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 10:04:21 +0200
Subject: [PATCH 2/3] phy: mvebu-cp110-comphy: remove unused member in private
 struct
In-Reply-To: <20170918080422.28972-1-antoine.tenart@free-electrons.com>
References: <20170918080422.28972-1-antoine.tenart@free-electrons.com>
Message-ID: <20170918080422.28972-2-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'modes' member of the mvebu_comphy_priv structure is not used.
Remove it.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 514a1a47e1fd..365f0abf5a2f 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -152,7 +152,6 @@ struct mvebu_comphy_priv {
 	void __iomem *base;
 	struct regmap *regmap;
 	struct device *dev;
-	int modes[MVEBU_COMPHY_LANES];
 };
 
 struct mvebu_comphy_lane {
-- 
2.13.5
