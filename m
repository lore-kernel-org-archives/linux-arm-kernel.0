From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 9 Nov 2018 17:47:55 -0600
Subject: [PATCH v2 5/5] phy: core: clean up unused ethernet specific phy modes
In-Reply-To: <20181109234755.21687-1-grygorii.strashko@ti.com>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
Message-ID: <20181109234755.21687-6-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After recent changes PHY_MODE_SGMII, PHY_MODE_2500SGMII, PHY_MODE_QSGMII,
PHY_MODE_10GKR are not used any more and can be removed. Hence - remove
them.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/phy/phy.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 02c9ef0..79da05a 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -35,10 +35,6 @@ enum phy_mode {
 	PHY_MODE_USB_DEVICE_HS,
 	PHY_MODE_USB_DEVICE_SS,
 	PHY_MODE_USB_OTG,
-	PHY_MODE_SGMII,
-	PHY_MODE_2500SGMII,
-	PHY_MODE_QSGMII,
-	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
 	PHY_MODE_PCIE,
-- 
2.10.5
