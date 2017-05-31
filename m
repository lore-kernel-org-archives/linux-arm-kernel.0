From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 31 May 2017 09:18:52 +0200
Subject: [PATCH v6 21/21] arm64: defconfig: Enable dwmac-sun8i driver on
 defconfig
In-Reply-To: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
Message-ID: <20170531071852.12422-22-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the dwmac-sun8i ethernet driver as a module in the ARM64 defconfig.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 000de61802a1..fd7d22b8480c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -191,6 +191,7 @@ CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=m
+CONFIG_DWMAC_SUN8I=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
-- 
2.13.0
