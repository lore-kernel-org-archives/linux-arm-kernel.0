From: rogerq@ti.com (Roger Quadros)
Date: Fri, 1 Aug 2014 14:25:04 +0300
Subject: [REBASED PATCH] ARM: multi_v7_defconfig: Enable TI PIPE3 PHY driver
In-Reply-To: <20140730195242.GF18384@quad.lixom.net>
References: <1406540737-9493-1-git-send-email-rogerq@ti.com>
 <1406625328-26112-1-git-send-email-rogerq@ti.com>
 <20140730195242.GF18384@quad.lixom.net>
Message-ID: <53DB7910.1010808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roger Quadros <rogerq@ti.com>

This driver is needed by SATA, PCIe and USB modules on TI SoCs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8403b9c..18fb2aa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -383,6 +383,7 @@ CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
 CONFIG_OMAP_USB2=y
+CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
-- 
1.8.3.2
