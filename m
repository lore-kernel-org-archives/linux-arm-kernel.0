From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 22 Aug 2014 08:54:32 -0700
Subject: [PATCH 07/11] ARM: multi_v7_defconfig: Enable Xilinx SPI driver
In-Reply-To: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1408722876-7791-8-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 68a4c6b04f2b..d37aafa7c0f5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -218,6 +218,7 @@ CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA114=y
 CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
+CONFIG_SPI_XILINX=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
 CONFIG_GPIO_SYSFS=y
-- 
2.0.1.1.gfbfc394
