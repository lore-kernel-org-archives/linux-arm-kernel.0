From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Dec 2013 18:25:34 +0100
Subject: [PATCH 3/5] ARM: versatile: enable GPIOLIB and PL061 by default
Message-ID: <1387560334-21499-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the GPIOLIB and PL061 in the Versatile defconfig, as this
is present on all boards, and so we get compile and test coverage
for this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/versatile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 0756efd8b554..bb83c099d5a6 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -45,6 +45,8 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=m
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
-- 
1.8.3.1
