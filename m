From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Mon, 19 Oct 2015 14:32:26 -0300
Subject: [PATCH v2 4/4] ARM: configs: lpc18xx: enable EEPROM NVMEM driver
In-Reply-To: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <1445275946-32653-5-git-send-email-ariel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable NVMEM driver for NXP LPC18xx EEPROM, which can be found in
NXP LPC185x/3x and LPC435x/3x/2x/1x devices.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 arch/arm/configs/lpc18xx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index b758a80..2c7e0da 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -149,6 +149,8 @@ CONFIG_ARM_PL172_MPMC=y
 CONFIG_PWM=y
 CONFIG_PWM_LPC18XX_SCT=y
 CONFIG_PHY_LPC18XX_USB_OTG=y
+CONFIG_NVMEM=y
+CONFIG_NVMEM_LPC18XX_EEPROM=y
 CONFIG_EXT2_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
-- 
2.6.1
