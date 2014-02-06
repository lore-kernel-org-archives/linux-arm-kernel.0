From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:22 +0900
Subject: [PATCH 02/13] ARM: shmobile: koelsch: Enable SATA in defconfig
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
Message-ID: <7f03e3bf2bca488e1471e00b6b8b74242b065020.1391651074.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This enables block layer, R-Car SATA and SCSI disk in koelsch_defconfig.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/koelsch_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index e248f49..4071e61 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -8,7 +8,6 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
-# CONFIG_BLOCK is not set
 CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_MACH_KOELSCH=y
@@ -36,6 +35,9 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
-- 
1.8.5.2
