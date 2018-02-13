From: d.schultz@phytec.de (Daniel Schultz)
Date: Tue, 13 Feb 2018 10:39:18 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_DP83867_PHY
Message-ID: <1518514758-21759-1-git-send-email-d.schultz@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the driver for TI's DP83867 ethernet phy.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 61509c4..8313fa1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -265,6 +265,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_BROADCOM_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_MICREL_PHY=y
-- 
2.7.4
