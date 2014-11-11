From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 10 Nov 2014 21:39:50 -0600
Subject: [PATCH] ARM: multi_v7_defconfig: enable designware watchdog driver
Message-ID: <1415677190-32695-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The dw watchdog can be found on the socfpga and rockchip platforms.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3487046..3d4b9bf 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -263,6 +263,7 @@ CONFIG_XILINX_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
+CONFIG_DW_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_CROS_EC=y
-- 
2.0.3
