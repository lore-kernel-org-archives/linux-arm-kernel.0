From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 22 Aug 2014 08:54:35 -0700
Subject: [PATCH 10/11] ARM: multi_v7_defconfig: Enable Xilinx emaclite driver
In-Reply-To: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1408722876-7791-11-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2aa2c5b4bd7e..ddb8a070ba6f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -148,6 +148,7 @@ CONFIG_R8169=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
 CONFIG_TI_CPSW=y
+CONFIG_XILINX_EMACLITE=y
 CONFIG_AT803X_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_ICPLUS_PHY=y
-- 
2.0.1.1.gfbfc394
