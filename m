From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Aug 2012 02:39:47 +0000
Subject: [PATCH 3/3] ARM: Kirkwood: add DT boards to defconfig
In-Reply-To: <cover.1344651264.git.jason@lakedaemon.net>
References: <cover.1344651264.git.jason@lakedaemon.net>
Message-ID: <a0e20df2d8ad6dbcf66fa9a14482a305c4a109fe.1344651264.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, disable DEBUG_KERNEL, enable SERIAL_OF_PLATFORM, and enable EMBEDDED

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/configs/kirkwood_defconfig |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 5a494a3..0865d2e 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -3,6 +3,9 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=19
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_KPROBES=y
@@ -17,6 +20,13 @@ CONFIG_MACH_MV88F6281GTW_GE=y
 CONFIG_MACH_SHEEVAPLUG=y
 CONFIG_MACH_ESATA_SHEEVAPLUG=y
 CONFIG_MACH_GURUPLUG=y
+CONFIG_MACH_DREAMPLUG_DT=y
+CONFIG_MACH_ICONNECT_DT=y
+CONFIG_MACH_DLINK_KIRKWOOD_DT=y
+CONFIG_MACH_IB62X0_DT=y
+CONFIG_MACH_TS219_DT=y
+CONFIG_MACH_GOFLEXNET_DT=y
+CONFIG_MACH_LSXL_DT=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
 CONFIG_MACH_DOCKSTAR=y
@@ -89,6 +99,7 @@ CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
@@ -157,7 +168,6 @@ CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_INFO=y
-- 
1.7.8.6
