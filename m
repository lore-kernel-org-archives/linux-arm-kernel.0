From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Jul 2014 08:55:49 +0900
Subject: [PATCH 2/2] ARM: shmobile: defconfig: Remove MACH_GENMAI
In-Reply-To: <cover.1405640905.git.horms+renesas@verge.net.au>
References: <cover.1405640905.git.horms+renesas@verge.net.au>
Message-ID: <92db2b7af591d3c3212183a34856b4cb190b6999.1405640905.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The CONFIG_MACH_GENMAI is scheduled for removal so remove it from
shmobile_defconfig.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas at verge.net.au: revised changelog for updated commit order]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 6bc85a5..3b13614 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,7 +14,6 @@ CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
-CONFIG_MACH_GENMAI=y
 CONFIG_MACH_KOELSCH=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_MARZEN=y
-- 
2.0.1
