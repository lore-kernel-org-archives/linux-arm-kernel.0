From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 10:44:46 +0100
Subject: [PATCH net-next v3 7/7] net: phy: meson-gxl: join the authors
In-Reply-To: <20171218094446.31912-1-jbrunet@baylibre.com>
References: <20171218094446.31912-1-jbrunet@baylibre.com>
Message-ID: <20171218094446.31912-8-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following previous changes, join the other authors of this driver and
take the blame with them

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index ee0aa18af631..ddc2c5ea3787 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -255,4 +255,5 @@ MODULE_DEVICE_TABLE(mdio, meson_gxl_tbl);
 MODULE_DESCRIPTION("Amlogic Meson GXL Internal PHY driver");
 MODULE_AUTHOR("Baoqi wang");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL");
-- 
2.14.3
