From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 26 Jan 2018 16:19:27 +0100
Subject: [PATCH 02/16] arm: config: sunxi_defconfig: enable SUN4I_GPADC
In-Reply-To: <20180126151941.12183-1-embed3d@gmail.com>
References: <20180126151941.12183-1-embed3d@gmail.com>
Message-ID: <20180126151941.12183-3-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the SUN4I_GPADC config option and
sets the value to yes. This is needed to enable the ths sensors.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 5caaf971fb50..52c3990b9d91 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -131,6 +131,7 @@ CONFIG_DMA_SUN6I=y
 CONFIG_EXTCON=y
 CONFIG_IIO=y
 CONFIG_AXP20X_ADC=y
+CONFIG_SUN4I_GPADC=y
 CONFIG_PWM=y
 CONFIG_PWM_SUN4I=y
 CONFIG_PHY_SUN4I_USB=y
-- 
2.11.0
