From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 28 Aug 2017 11:44:20 +0200
Subject: [PATCH] arm64: defconfig: enable the Marvell 10G PHY as a module
Message-ID: <20170828094420.12357-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell 10G PHY is present on mvebu platforms. Enable it as a module
so that the network works on these platforms.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e671e37b30af..d453ba50df43 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -200,6 +200,7 @@ CONFIG_STMMAC_ETH=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_AT803X_PHY=m
 CONFIG_MARVELL_PHY=m
+CONFIG_MARVELL_10G_PHY=m
 CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=m
-- 
2.13.5
