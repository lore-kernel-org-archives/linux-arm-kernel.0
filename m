From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 24 Nov 2011 14:58:06 +0100
Subject: [PATCH 3/3] ARM: at91: enable additional boards in existing soc
 defconfig files
In-Reply-To: <201111232115.08556.arnd@arndb.de>
References: <201111232115.08556.arnd@arndb.de>
Message-ID: <1322143086-1788-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/at91sam9260_defconfig |   12 ++++++++++++
 arch/arm/configs/at91sam9g20_defconfig |   11 +++++++++++
 arch/arm/configs/at91sam9g45_defconfig |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/at91sam9260_defconfig b/arch/arm/configs/at91sam9260_defconfig
index 8a4c22d..505b376 100644
--- a/arch/arm/configs/at91sam9260_defconfig
+++ b/arch/arm/configs/at91sam9260_defconfig
@@ -12,11 +12,23 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91SAM9260=y
+CONFIG_ARCH_AT91SAM9260_SAM9XE=y
 CONFIG_MACH_AT91SAM9260EK=y
+CONFIG_MACH_CAM60=y
+CONFIG_MACH_SAM9_L9260=y
+CONFIG_MACH_AFEB9260=y
+CONFIG_MACH_USB_A9260=y
+CONFIG_MACH_QIL_A9260=y
+CONFIG_MACH_CPU9260=y
+CONFIG_MACH_FLEXIBITY=y
+CONFIG_MACH_SNAPPER_9260=y
+CONFIG_MACH_AT91SAM_DT=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev/ram0 rw"
 CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/at91sam9g20_defconfig b/arch/arm/configs/at91sam9g20_defconfig
index 23966c6..9123568 100644
--- a/arch/arm/configs/at91sam9g20_defconfig
+++ b/arch/arm/configs/at91sam9g20_defconfig
@@ -14,6 +14,15 @@ CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91SAM9G20=y
 CONFIG_MACH_AT91SAM9G20EK=y
 CONFIG_MACH_AT91SAM9G20EK_2MMC=y
+CONFIG_MACH_CPU9G20=y
+CONFIG_MACH_ACMENETUSFOXG20=y
+CONFIG_MACH_PORTUXG20=y
+CONFIG_MACH_STAMP9G20=y
+CONFIG_MACH_PCONTROL_G20=y
+CONFIG_MACH_GSIA18S=y
+CONFIG_MACH_USB_A9G20=y
+CONFIG_MACH_SNAPPER_9260=y
+CONFIG_MACH_AT91SAM_DT=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_AEABI=y
@@ -21,6 +30,8 @@ CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev/ram0 rw"
 CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/at91sam9g45_defconfig b/arch/arm/configs/at91sam9g45_defconfig
index 7f8f999..606d48f 100644
--- a/arch/arm/configs/at91sam9g45_defconfig
+++ b/arch/arm/configs/at91sam9g45_defconfig
@@ -18,6 +18,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91SAM9G45=y
 CONFIG_MACH_AT91SAM9M10G45EK=y
+CONFIG_MACH_AT91SAM_DT=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 CONFIG_AT91_SLOW_CLOCK=y
 CONFIG_AEABI=y
-- 
1.7.7
