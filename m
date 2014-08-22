From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 22 Aug 2014 08:54:34 -0700
Subject: [PATCH 09/11] ARM: multi_v7_defconfig: Enable Xilinx VDMA driver
In-Reply-To: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1408722876-7791-10-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e696c5784579..2aa2c5b4bd7e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -371,6 +371,7 @@ CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
 CONFIG_MXS_DMA=y
 CONFIG_DMA_OMAP=y
+CONFIG_XILINX_VDMA=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
2.0.1.1.gfbfc394
