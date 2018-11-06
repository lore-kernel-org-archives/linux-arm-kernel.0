From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  6 Nov 2018 15:54:13 +0100
Subject: [PATCH v2 1/9] phy: Add MIPI D-PHY mode
In-Reply-To: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
Message-ID: <74b2dfd695a5d28f9a07634cea17acec0a6aaa49.1541516029.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MIPI D-PHY is a MIPI standard meant mostly for display and cameras in
embedded systems. Add a mode for it.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 03b319f89a34..d5c2ac7369f2 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -42,6 +42,7 @@ enum phy_mode {
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
 	PHY_MODE_PCIE,
+	PHY_MODE_MIPI_DPHY,
 };
 
 /**
-- 
git-series 0.9.1
