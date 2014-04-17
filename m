From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu, 17 Apr 2014 10:42:30 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: select CONFIG_GPIO_DWAPB
Message-ID: <1397724150-14055-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly integrated dwapb gpio driver handles the Berlin SoCs GPIOs.
Add this driver to the multi_v7_defconfig.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 This patch applies on top of Alexandre's one selecting
 CONFIG_MACH_BERLIN_BG2Q:
 https://patchwork.kernel.org/patch/3876171/

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b61a211cc221..ded037aff67d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -192,6 +192,7 @@ CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_GPIO_PALMAS=y
-- 
1.8.3.2
