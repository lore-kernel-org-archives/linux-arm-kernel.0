From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  9 Jan 2018 09:59:42 +0100
Subject: [PATCH net-next v3 1/4] phy: add 2.5G SGMII mode to the phy_mode enum
In-Reply-To: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
Message-ID: <20180109085945.11916-2-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds one more generic PHY mode to the phy_mode enum, to allow
configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
callback.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
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
