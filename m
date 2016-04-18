From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 18 Apr 2016 06:31:23 +0300
Subject: [PATCH 2/2] ARM: LPC32xx: add PL175 memory controller driver to
 defconfig
In-Reply-To: <1460950283-25053-1-git-send-email-vz@mleia.com>
References: <1460950283-25053-1-git-send-email-vz@mleia.com>
Message-ID: <1460950283-25053-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change enables build of ARM PrimeCell PL17x driver for LPC32xx
platform, the memory controller is commonly used to interface NOR
flash drives.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/configs/lpc32xx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 4303199..6ba430d 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -170,6 +170,8 @@ CONFIG_DMADEVICES=y
 CONFIG_AMBA_PL08X=y
 CONFIG_STAGING=y
 CONFIG_LPC32XX_ADC=y
+CONFIG_MEMORY=y
+CONFIG_ARM_PL172_MPMC=y
 CONFIG_IIO=y
 CONFIG_MAX517=y
 CONFIG_PWM=y
-- 
2.1.4
