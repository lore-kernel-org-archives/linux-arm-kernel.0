From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  8 Dec 2011 15:41:55 +0100
Subject: [PATCH 2/2] ARM: at91x40: refresh soc defconfig for 3.2
In-Reply-To: <1323355315-9767-1-git-send-email-plagnioj@jcrosoft.com>
References: <1323355315-9767-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1323355315-9767-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/at91x40_defconfig |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/at91x40_defconfig b/arch/arm/configs/at91x40_defconfig
index c55e921..875275f 100644
--- a/arch/arm/configs/at91x40_defconfig
+++ b/arch/arm/configs/at91x40_defconfig
@@ -1,10 +1,11 @@
+CONFIG_PHYS_OFFSET=0x20000000
 CONFIG_EXPERIMENTAL=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EMBEDDED=y
 # CONFIG_HOTPLUG is not set
 # CONFIG_ELF_CORE is not set
 # CONFIG_FUTEX is not set
 # CONFIG_TIMERFD is not set
+CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
@@ -16,7 +17,6 @@ CONFIG_SLAB=y
 CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91X40=y
 CONFIG_MACH_AT91EB01=y
-CONFIG_AT91_EARLY_USART0=y
 CONFIG_CPU_ARM7TDMI=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x01000000
@@ -26,10 +26,8 @@ CONFIG_PROCESSOR_ID=0x14000040
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_BINFMT_FLAT=y
-# CONFIG_SUSPEND is not set
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_RAM=y
-- 
1.7.7
