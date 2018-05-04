From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri,  4 May 2018 15:56:36 +0200
Subject: [PATCH net-next v2 06/13] phy: add 2.5G SGMII mode to the phy_mode
 enum
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Message-ID: <20180504135643.23466-7-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds one more generic PHY mode to the phy_mode enum, to allow
configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
callback.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index c9d14eeee7f5..9713aebdd348 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -36,6 +36,7 @@ enum phy_mode {
 	PHY_MODE_USB_DEVICE_SS,
 	PHY_MODE_USB_OTG,
 	PHY_MODE_SGMII,
+	PHY_MODE_2500SGMII,
 	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
-- 
2.17.0
