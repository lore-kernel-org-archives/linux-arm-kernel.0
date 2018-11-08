From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 7 Nov 2018 18:36:14 -0600
Subject: [PATCH 2/5] phy: core: add PHY_MODE_ETHERNET
In-Reply-To: <20181108003617.10334-1-grygorii.strashko@ti.com>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
Message-ID: <20181108003617.10334-3-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new PHY's mode to be used by Ethernet PHY interface drivers or
multipurpose PHYs like serdes. It will be reused in further changes.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b17e770..02c9ef0 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -42,6 +42,7 @@ enum phy_mode {
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
 	PHY_MODE_PCIE,
+	PHY_MODE_ETHERNET,
 };
 
 /**
-- 
2.10.5
