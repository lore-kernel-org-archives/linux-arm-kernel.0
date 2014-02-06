From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:27 +0900
Subject: [PATCH 07/13] ARM: shmobile: lager: enable CONFIG_DEVTMPFS in
 defconfig
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
Message-ID: <6ea8b5ff7ca2d200875ddd774faa8ca40d990d86.1391651074.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DEVTMPFS is needed for udev

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
[horms+renesas at verge.net.au: resolved trivial conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/lager_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index ee93b8a..3e7e0ae 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -49,6 +49,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
-- 
1.8.5.2
