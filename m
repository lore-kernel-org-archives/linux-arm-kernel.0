From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 11 Jul 2018 16:26:49 +0200
Subject: [PATCH] ARM: defconfig: Set CONFIG_LOCALVERSION in multi v4t/v5/v7
 defconfigs
Message-ID: <20180711142649.4556-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to derive the kernel flavor from the kernel version at
runtime.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Handle "new" multi_v4t_defconfig.
---
 arch/arm/configs/multi_v4t_defconfig | 1 +
 arch/arm/configs/multi_v5_defconfig  | 1 +
 arch/arm/configs/multi_v7_defconfig  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 9a6390c172d6b676..9bbb76e8260611df 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v4t"
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 7c41bee284630d14..5797c8b40c763b55 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v5"
 CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4c71fcb03bccfb8d..155d1eb10c6580fe 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v7"
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
2.17.1
