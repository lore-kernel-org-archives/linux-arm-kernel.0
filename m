From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 11 Aug 2012 22:33:17 +0000
Subject: [PATCH V2 2/2] ARM: Kirkwood: add DT boards to defconfig
In-Reply-To: <cover.1344720707.git.jason@lakedaemon.net>
References: <cover.1344720707.git.jason@lakedaemon.net>
Message-ID: <32f2ace6ba20829a29786aa650df79a4c7c9b86d.1344720707.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, enable SERIAL_OF_PLATFORM

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Changes from V1:
  - restrict changes to only DT boards and SERIAL_OF_PLATFORM

 arch/arm/configs/kirkwood_defconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 5a494a3..46e605f 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -17,6 +17,13 @@ CONFIG_MACH_MV88F6281GTW_GE=y
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
@@ -89,6 +96,7 @@ CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
-- 
1.7.8.6
