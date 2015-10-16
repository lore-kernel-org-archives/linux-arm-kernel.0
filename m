From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 16 Oct 2015 15:04:47 +0200
Subject: [PATCH v2 4/8] ARM: at91/defconfig: update at91_dt defconfig
In-Reply-To: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
References: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1445000691-12402-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial savedefconfig update.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/configs/at91_dt_defconfig | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 090c5b2..1b1e5ac 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -17,7 +17,6 @@ CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_AT91=y
-CONFIG_SOC_SAM_V4_V5=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
 CONFIG_AEABI=y
@@ -28,7 +27,6 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
 CONFIG_KEXEC=y
-CONFIG_AUTO_ZRELADDR=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -43,7 +41,6 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
-CONFIG_IPV6=y
 # CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET6_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET6_XFRM_MODE_BEET is not set
@@ -119,7 +116,6 @@ CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_ATMEL=y
 CONFIG_SERIAL_ATMEL_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_I2C=y
 CONFIG_I2C_AT91=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
@@ -142,16 +138,12 @@ CONFIG_SOC_CAMERA_OV2640=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_PANEL_SIMPLE=y
-CONFIG_FB=y
 CONFIG_FB_ATMEL=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_ATMEL_LCDC=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
@@ -216,18 +208,11 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_AES=y
-CONFIG_CRYPTO_ARC4=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=y
-CONFIG_CRC_ITU_T=y
-CONFIG_CRC7=m
-CONFIG_AVERAGE=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_ACORN_8x8=y
-- 
2.5.0
