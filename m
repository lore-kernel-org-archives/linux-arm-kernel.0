From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Dec 2013 18:25:49 +0100
Subject: [PATCH 4/5] ARM: versatile: build using EABI
Message-ID: <1387560349-21536-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should work just fine on this purely v5 platform, so let's
config it for EABI by default.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/versatile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index bb83c099d5a6..6d4c2df44c9c 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -8,6 +8,8 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_VERSATILE=y
 CONFIG_MACH_VERSATILE_AB=y
+CONFIG_AEABI=y
+CONFIG_OABI_COMPAT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 mem=32M"
-- 
1.8.3.1
