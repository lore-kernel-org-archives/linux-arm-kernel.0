From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  7 Dec 2017 15:27:15 +0100
Subject: [PATCH net-next v2 8/8] net: phy: meson-gxl: join the authors
In-Reply-To: <20171207142715.32578-1-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
Message-ID: <20171207142715.32578-9-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following previous changes, join the other authors of this driver and
take the blame with them

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 861b021b9758..4cd5b2622ae1 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -256,4 +256,5 @@ MODULE_DEVICE_TABLE(mdio, meson_gxl_tbl);
 MODULE_DESCRIPTION("Amlogic Meson GXL Internal PHY driver");
 MODULE_AUTHOR("Baoqi wang");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL");
-- 
2.14.3
