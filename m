From: david@lechnology.com (David Lechner)
Date: Mon,  9 Jan 2017 10:11:38 -0600
Subject: [RESEND 1/3] ARM: davinci_all_defconfig: enable DA8xx pinconf
In-Reply-To: <1483978300-403-1-git-send-email-david@lechnology.com>
References: <1483978300-403-1-git-send-email-david@lechnology.com>
Message-ID: <1483978300-403-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the DA8xx pinconf driver by default. It is needed by LEGO
MINDSTORMS EV3.

Signed-off-by: David Lechner <david@lechnology.com>
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
