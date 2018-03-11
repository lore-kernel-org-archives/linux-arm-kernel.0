From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Mar 2018 14:53:06 +0100
Subject: [PATCH 09/10] ARM: defconfig: Update Versatile defconfig
In-Reply-To: <20180311135307.6271-1-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
Message-ID: <20180311135307.6271-10-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Versatile defconfig to the latest savedefconfig
results reflecting changes in Kconfig. We add in the Flash memory
support that has been available upstream for a while now.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/versatile_defconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 295408ea9dc7..6a3e5774247e 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -32,7 +32,9 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_EEPROM_LEGACY=m
 CONFIG_NETDEVICES=y
@@ -54,14 +56,11 @@ CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
-CONFIG_MFD_SYSCON=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
 CONFIG_SND_ARMAACI=m
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
-- 
2.14.3
