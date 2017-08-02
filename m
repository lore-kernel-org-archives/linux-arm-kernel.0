From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 2 Aug 2017 15:18:22 -0500
Subject: [PATCH 3/3] ARM: configs: keystone: Enable D_CAN driver
In-Reply-To: <20170802201822.11532-1-fcooper@ti.com>
References: <20170802201822.11532-1-fcooper@ti.com>
Message-ID: <20170802201822.11532-4-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable C_CAN/D_CAN driver supported by 66AK2G

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/configs/keystone_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index d47ea43..47be99e 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -112,6 +112,9 @@ CONFIG_IP_NF_ARP_MANGLE=y
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_SCTP=y
 CONFIG_VLAN_8021Q=y
+CONFIG_CAN=m
+CONFIG_CAN_C_CAN=m
+CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
2.9.4.dirty
