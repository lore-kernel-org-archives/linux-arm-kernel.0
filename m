From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:04 +0200
Subject: [PATCH v2 01/17] ARM: mvebu: enable MTD command line partition table
 in mvebu_v7_defconfig
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-2-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell EBU v7 platforms contain various MTD devices, therefore it makes
sense to allow configuring the MTD partition tables via the kernel command
line.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 486a4ca..f43a7aa 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -48,6 +48,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
-- 
1.8.3.1
