From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 18:15:44 +0200
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: add Atmel watchdog timers
In-Reply-To: <1459347577-15450-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459347577-15450-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <c1ec7d16df28a0f9d72c1106f21f1f013a0011c1.1461687187.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add both Atmel watchdog timers to the multi_v7_defconfig. They are added
as part of the kernel because it's a core piece of the system.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index af1e0c91a6f2..d72ee27cecae 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -430,6 +430,8 @@ CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
+CONFIG_AT91SAM9X_WATCHDOG=y
+CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
-- 
2.1.3
