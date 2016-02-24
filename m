From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 24 Feb 2016 16:03:18 +0100
Subject: [PATCH 1/2] ARM: multi_v5_defconfig: Cleanup multi_v5_defconfig
Message-ID: <1456326199-12438-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

Regenerate multi_v5_defconfig by running:
make multi_v5_defconfig
make savedefconfig
mv defconfig arch/arm/configs/multi_v5_defconfig

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/configs/multi_v5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 1f9ca47..fcbc633 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -97,9 +97,9 @@ CONFIG_NET_DSA_MV88E6352=y
 CONFIG_MV643XX_ETH=y
 CONFIG_R8169=y
 CONFIG_MARVELL_PHY=y
-CONFIG_MWL8K=m
 CONFIG_LIBERTAS=y
 CONFIG_LIBERTAS_SDIO=y
+CONFIG_MWL8K=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
-- 
2.7.0
