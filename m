From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 12 Apr 2017 13:14:00 +0200
Subject: [PATCH v4 18/18] arm: multi_v7: Enable dwmac-sun8i driver on
 multi_v7_defconfig
In-Reply-To: <20170412111400.2296-1-clabbe.montjoie@gmail.com>
References: <20170412111400.2296-1-clabbe.montjoie@gmail.com>
Message-ID: <20170412111400.2296-19-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the dwmac-sun8i driver in the multi_v7 default configuration

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f6167e..5a553ba 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -257,6 +257,7 @@ CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
 CONFIG_STMMAC_PLATFORM=y
 CONFIG_DWMAC_DWC_QOS_ETH=y
+CONFIG_DWMAC_SUN8I=y
 CONFIG_TI_CPSW=y
 CONFIG_XILINX_EMACLITE=y
 CONFIG_AT803X_PHY=y
-- 
2.10.2
