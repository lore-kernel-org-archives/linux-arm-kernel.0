From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 14 Aug 2015 22:46:25 -0400 (EDT)
Subject: [PATCH] ARM: add TC2 PM support to multi_v7_defconfig
Message-ID: <alpine.LFD.2.20.1508142239070.1515@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, the multi_v7_defconfig kernel cannot boot all CPUs
nor do deep cpuidle power saving on a TC2 board.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fd8df6f50..d91b8783f2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -98,6 +98,7 @@ CONFIG_MACH_SNOWBALL=y
 CONFIG_MACH_UX500_DT=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_CA9X4=y
+CONFIG_ARCH_VEXPRESS_TC2_PM=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
 CONFIG_TRUSTED_FOUNDATIONS=y
