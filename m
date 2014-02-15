From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 15 Feb 2014 12:05:32 +0400
Subject: [PATCH 3/4] ARM: clps711x: Update defconfig
In-Reply-To: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
References: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
Message-ID: <1392451533-12858-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the CLPS711X defconfig to the thing saved by savedefconfig.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/clps711x_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 9e8c831..0facf9d 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -15,7 +15,6 @@ CONFIG_ARCH_CDB89712=y
 CONFIG_ARCH_CLEP7312=y
 CONFIG_ARCH_EDB7211=y
 CONFIG_ARCH_P720T=y
-CONFIG_ARCH_FORTUNET=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -27,7 +26,6 @@ CONFIG_INET=y
 # CONFIG_IPV6 is not set
 CONFIG_IRDA=y
 CONFIG_IRTTY_SIR=y
-CONFIG_EP7211_DONGLE=y
 # CONFIG_WIRELESS is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -58,6 +56,7 @@ CONFIG_CS89x0_PLATFORM=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
+CONFIG_SERIAL_CLPS711X=y
 CONFIG_SERIAL_CLPS711X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
-- 
1.8.3.2
