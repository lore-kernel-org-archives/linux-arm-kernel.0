From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Apr 2013 12:29:52 +0900
Subject: [RFC/PATCH 6/7] ARM: shmobile: defconfig: Remove kzm9d defconfig
In-Reply-To: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365046193-19369-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove kzm9d defconfig as the shmobile defconfig may now be used instead.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9d_defconfig |   88 --------------------------------------
 1 file changed, 88 deletions(-)
 delete mode 100644 arch/arm/configs/kzm9d_defconfig

diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
deleted file mode 100644
index 6c37f4a..0000000
--- a/arch/arm/configs/kzm9d_defconfig
+++ /dev/null
@@ -1,88 +0,0 @@
-# CONFIG_ARM_PATCH_PHYS_VIRT is not set
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=16
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-CONFIG_SLAB=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
-CONFIG_ARCH_EMEV2=y
-CONFIG_MACH_KZM9D=y
-CONFIG_MEMORY_START=0x40000000
-CONFIG_MEMORY_SIZE=0x10000000
-# CONFIG_SH_TIMER_TMU is not set
-# CONFIG_SWP_EMULATE is not set
-# CONFIG_CACHE_L2X0 is not set
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
-CONFIG_HOTPLUG_CPU=y
-# CONFIG_LOCAL_TIMERS is not set
-CONFIG_AEABI=y
-# CONFIG_OABI_COMPAT is not set
-# CONFIG_CROSS_MEMORY_ATTACH is not set
-CONFIG_FORCE_MAX_ZONEORDER=13
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_ARM_APPENDED_DTB=y
-CONFIG_VFP=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_BLK_DEV is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CHELSIO is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-CONFIG_SMSC911X=y
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_EM=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_GPIOLIB=y
-CONFIG_GPIO_EM=y
-# CONFIG_HWMON is not set
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_IOMMU_SUPPORT is not set
-# CONFIG_DNOTIFY is not set
-CONFIG_TMPFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-# CONFIG_FTRACE is not set
-- 
1.7.10.4
