From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  1 May 2017 14:45:19 +0200
Subject: [PATCH v5 19/20] arm: multi_v7: Enable dwmac-sun8i driver on
 multi_v7_defconfig
In-Reply-To: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
Message-ID: <20170501124520.3769-20-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the dwmac-sun8i driver in the multi_v7 default configuration

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2685e03..6da6af8 100644
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
