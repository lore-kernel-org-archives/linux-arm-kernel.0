From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 28 Jun 2018 10:06:15 +0300
Subject: [PATCH 2/2] ARM: mvebu_v7_defconfig: enable SFP support
In-Reply-To: <ee69693c87cd0146f259042fc5dcd29338fcdf25.1530169575.git.baruch@tkos.co.il>
References: <ee69693c87cd0146f259042fc5dcd29338fcdf25.1530169575.git.baruch@tkos.co.il>
Message-ID: <b130ccb8a9812530d33a71afb1563545fa8808cf.1530169575.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for SFP cages on SolidRun Armada 38x and 8k
platforms.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 1ff371ae688d..55140219ab11 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -66,6 +66,7 @@ CONFIG_NETDEVICES=y
 CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
 CONFIG_MVPP2=y
+CONFIG_SFP=y
 CONFIG_MARVELL_PHY=y
 CONFIG_MWIFIEX=y
 CONFIG_MWIFIEX_SDIO=y
-- 
2.18.0
