From: david@lechnology.com (David Lechner)
Date: Thu,  5 Jan 2017 22:33:44 -0600
Subject: [PATCH v2 1/5] ARM: davinci_all_defconfig: enable DA8xx pinconf
In-Reply-To: <1483677228-2325-1-git-send-email-david@lechnology.com>
References: <1483677228-2325-1-git-send-email-david@lechnology.com>
Message-ID: <1483677228-2325-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the DA8xx pinconf driver by default. It is needed by LEGO
MINDSTORMS EV3.
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index ddb586a..a12e4c2 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -114,6 +114,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DAVINCI=y
 CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=m
+CONFIG_PINCTRL_DA850_PUPD=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
-- 
2.7.4
