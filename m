From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  1 May 2017 14:45:20 +0200
Subject: [PATCH v5 20/20] arm64: defconfig: Enable dwmac-sun8i driver on
 defconfig
In-Reply-To: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
Message-ID: <20170501124520.3769-21-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the dwmac-sun8i ethernet driver as a module in the ARM64 defconfig.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ce07285..4575fbb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -193,6 +193,7 @@ CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=m
+CONFIG_DWMAC_SUN8I=m
 CONFIG_REALTEK_PHY=m
 CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
-- 
2.10.2
