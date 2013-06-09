From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  9 Jun 2013 18:36:07 +0200
Subject: [PATCH 6/6] ARM: multi_v7: Enable Allwinner EMAC in multi_v7_defconfig
In-Reply-To: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1370795767-9769-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2e67a27..4aa6401 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -31,10 +31,12 @@ CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
+CONFIG_SUN4I_EMAC=y
 CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
 CONFIG_SERIO_AMBAKMI=y
+CONFIG_MDIO_SUN4I=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
-- 
1.8.3
