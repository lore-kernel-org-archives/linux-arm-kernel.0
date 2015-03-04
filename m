From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  4 Mar 2015 18:06:31 +0000
Subject: [PATCH v5 2/9] ARM: multi_v7_defconfig: Enable support for ST's LPC
 Watchdog
In-Reply-To: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
References: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1425492398-27340-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e8a4c95..0f172f8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -288,6 +288,7 @@ CONFIG_WATCHDOG=y
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3722=y
-- 
1.9.1
