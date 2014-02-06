From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:30 +0900
Subject: [PATCH 10/13] ARM: shmobile: genmai: enable CONFIG_DEVTMPFS in
 defconfig
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
Message-ID: <2304de6ef7479b12fa4529c12a53cac631a2c67b.1391651074.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DEVTMPFS is needed for udev

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/genmai_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index aa0b704..c56a7ff 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -50,6 +50,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CORE is not set
 # CONFIG_NET_VENDOR_ARC is not set
-- 
1.8.5.2
