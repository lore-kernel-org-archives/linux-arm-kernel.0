From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:10 +0900
Subject: [PATCH 5/7] ARM: shmobile: Enable HIGHMEM in shmobile_defconfig
In-Reply-To: <cover.1397627278.git.horms+renesas@verge.net.au>
References: <cover.1397627278.git.horms+renesas@verge.net.au>
Message-ID: <667d0f7b0e940bf36e8d12bd7d64aa0f9217b3ac.1397627278.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Many mach-shmobile hardware platforms include support for more
than 1GiB of RAM. Enable HIGHMEM by default to allow use of
larger amounts of memory.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index c10e626..b73a038 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -25,6 +25,7 @@ CONFIG_SCHED_MC=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_NR_CPUS=8
 CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-- 
1.8.5.2
