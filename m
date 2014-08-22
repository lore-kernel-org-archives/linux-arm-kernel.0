From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 22 Aug 2014 08:54:31 -0700
Subject: [PATCH 06/11] ARM: multi_v7_defconfig: Enable Xilinx I2C driver
In-Reply-To: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1408722876-7791-7-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5cc1c837f8cd..68a4c6b04f2b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -207,6 +207,7 @@ CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_ST=y
 CONFIG_SPI=y
+CONFIG_I2C_XILINX=y
 CONFIG_SPI_CADENCE=y
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
-- 
2.0.1.1.gfbfc394
