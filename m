From: j-keerthy@ti.com (Keerthy)
Date: Mon, 23 May 2016 17:59:07 +0530
Subject: [PATCH 3/3] ARM: configs: keystone: Enable PINCTRL_SINGLE Config
In-Reply-To: <1464006547-19569-1-git-send-email-j-keerthy@ti.com>
References: <1464006547-19569-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1464006547-19569-4-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

keystone-k2l devices use pinmux and are compliant with PINCTRL_SINGLE.
Hence enable the config option.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index faba04d..71b42e6 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -144,6 +144,7 @@ CONFIG_I2C_DAVINCI=y
 CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
+CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DAVINCI=y
-- 
1.9.1
