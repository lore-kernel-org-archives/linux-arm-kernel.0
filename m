From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:03:36 +0900
Subject: [PATCH 3/7] ARM: shmobile: genmai: Rename ARCH_SHMOBILE to
 ARCH_SHMOBILE_LEGACY
In-Reply-To: <cover.1387854925.git.horms+renesas@verge.net.au>
References: <cover.1387854925.git.horms+renesas@verge.net.au>
Message-ID: <7f558a124022630e177f08bbdd0673c3301f7e84.1387854925.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The ARCH_SHMOBILE configuration option has been renamed to
ARCH_SHMOBILE_LEGACY. Update the defconfig accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
[ horms+renesas at verge.net.au: Removed non-genmai changes which
  have been squashed into "ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY". ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/genmai_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index 69b1531..aa0b704 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -12,7 +12,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_MACH_GENMAI=y
 # CONFIG_SH_TIMER_CMT is not set
-- 
1.8.4
