From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:24 +0900
Subject: [PATCH 04/13] ARM: shmobile: lager: Enable SATA in defconfig
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
Message-ID: <0e02971e4047e61edc913c997ba9124df33d5112.1391651074.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This enables R-Car SATA and SCSI disk in lager_defconfig.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/lager_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 89b6e71..ee93b8a 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -49,6 +49,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CORE is not set
 # CONFIG_NET_VENDOR_ARC is not set
-- 
1.8.5.2
