From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  2 Jul 2014 14:56:18 +0200
Subject: [PATCH 2/2] ARM: kirkwood: add devtmpfs to kirkwood_defconfig
In-Reply-To: <1404305778-17757-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404305778-17757-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404305778-17757-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devtmpfs filesystem is now widely used and generally needed to
boot Linux systems. 42 ARM defconfigs have it enabled, so it makes
sense to have it enabled as well in kirkwood_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/kirkwood_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 2da96bc..5827c5f 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -49,6 +49,8 @@ CONFIG_NET_PKTGEN=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-- 
2.0.0
