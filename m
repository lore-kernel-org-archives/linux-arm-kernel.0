From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 13:31:34 +0900
Subject: [PATCH 3/3] ARM: shmobile: ape6evm: add defconfig
In-Reply-To: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
References: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364877094-1508-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add defconfig for ape6evm. This is based loosely
on the kzm9g defconfig with fewer devices enabled.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/ape6evm_defconfig |   95 ++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 arch/arm/configs/ape6evm_defconfig

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
new file mode 100644
index 0000000..dab5a7d
--- /dev/null
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -0,0 +1,95 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+CONFIG_SLAB=y
+# CONFIG_BLOCK is not set
+CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_R8A73A4=y
+CONFIG_MACH_APE6EVM=y
+# CONFIG_ARM_THUMB is not set
+CONFIG_CPU_BPREDICT_DISABLE=y
+CONFIG_PL310_ERRATA_588369=y
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_SMP=y
+CONFIG_SCHED_MC=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_NR_CPUS=8
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_HIGHPTE=y
+# CONFIG_HW_PERF_EVENTS is not set
+# CONFIG_COMPACTION is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_BINFMT_MISC=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6_SIT is not set
+CONFIG_NETFILTER=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FW_LOADER_USER_HELPER is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_CADENCE is not set
+CONFIG_SMC91X=y
+CONFIG_SMSC911X=y
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=12
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_GPIO_SH_PFC=y
+CONFIG_GPIOLIB=y
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_RCAR_THERMAL=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_GPIO=y
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_ROOT_NFS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_ENABLE_DEFAULT_TRACERS=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_MICHAEL_MIC=y
+CONFIG_CRYPTO_TWOFISH=y
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC7=y
+CONFIG_LIBCRC32C=y
-- 
1.7.10.4
