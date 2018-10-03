From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Oct 2018 11:13:51 -0300
Subject: [PATCH v2 4/6] ARM: mxs_defconfig: Remove unneeded options
In-Reply-To: <1538576033-23415-1-git-send-email-festevam@gmail.com>
References: <1538576033-23415-1-git-send-email-festevam@gmail.com>
Message-ID: <1538576033-23415-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the following unneeded config options:

- CONFIG_ARM_THUMB is selected by default

- CONFIG_I2C is selected by default.

- CONFIG_FRAMEBUFFER_CONSOLE is selected by default

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Split into a new patch the config options that were removed

 arch/arm/configs/mxs_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 2119a6a..3848059 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -18,7 +18,6 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXS=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_AEABI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
@@ -80,7 +79,6 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_MXS_AUART=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MXS=y
@@ -102,7 +100,6 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-- 
2.7.4
