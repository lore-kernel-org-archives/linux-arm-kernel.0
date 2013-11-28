From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 18:08:37 +0900
Subject: [PATCH 07/16] ARM: shmobile: bockw: Enable CONFIG_VFP in defconfig
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
Message-ID: <5a14cbb732a6a4eff2a0be59deba6fdb890253b8.1385629477.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_VFP is required to boot into a Debian armhf user-space.
This change brings the bockw defconfig into line with
other shmobile defconfigs.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 63e8bcd..8b5866e 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -27,6 +27,7 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
+CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
 CONFIG_PM_RUNTIME=y
-- 
1.8.4
