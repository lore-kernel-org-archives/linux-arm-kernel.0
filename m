From: j-keerthy@ti.com (Keerthy)
Date: Mon, 6 Jun 2016 10:15:06 +0530
Subject: [PATCH 3/3] ARM: configs: keystone: Enable PINCTRL_SINGLE Config
In-Reply-To: <1465188306-32556-1-git-send-email-j-keerthy@ti.com>
References: <1465188306-32556-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1465188306-32556-4-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Newer Keystone 2 devices utilize pinmuxing. Enable PINCTRL SINGLE
which is used to handle pinmuxing.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
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
