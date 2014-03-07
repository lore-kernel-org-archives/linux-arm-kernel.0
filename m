From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 7 Mar 2014 14:02:55 +0530
Subject: [PATCH v4] phy: omap-control: update dra7 and am437 usb2 bindings
Message-ID: <1394181175-16112-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roger Quadros <rogerq@ti.com>

The dra7-usb2 and am437-usb2 bindings have not yet been used.
Change them to be more elegant.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v3:
Changed the compatible value to that suggested by Tony.
ti,control-phy-usb2-dra7 and ti,control-phy-usb2-am437.

Changes from v2:
Kept only the drivers/phy part in this patch

 drivers/phy/phy-omap-control.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-omap-control.c b/drivers/phy/phy-omap-control.c
index 17fc200..a7e2d7f 100644
--- a/drivers/phy/phy-omap-control.c
+++ b/drivers/phy/phy-omap-control.c
@@ -228,11 +228,11 @@ static const struct of_device_id omap_control_phy_id_table[] = {
 		.data = &pipe3_data,
 	},
 	{
-		.compatible = "ti,control-phy-dra7usb2",
+		.compatible = "ti,control-phy-usb2-dra7",
 		.data = &dra7usb2_data,
 	},
 	{
-		.compatible = "ti,control-phy-am437usb2",
+		.compatible = "ti,control-phy-usb2-am437",
 		.data = &am437usb2_data,
 	},
 	{},
-- 
1.7.9.5
