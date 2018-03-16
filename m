From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 16 Mar 2018 11:33:45 +0100
Subject: [PATCH net-next 04/10] phy: add 2.5G SGMII mode to the phy_mode enum
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Message-ID: <20180316103351.16616-5-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds one more generic PHY mode to the phy_mode enum, to allow
configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
callback.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 4f8423a948d5..5a80e9de3686 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -28,6 +28,7 @@ enum phy_mode {
 	PHY_MODE_USB_DEVICE,
 	PHY_MODE_USB_OTG,
 	PHY_MODE_SGMII,
+	PHY_MODE_2500SGMII,
 	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
-- 
2.14.3
