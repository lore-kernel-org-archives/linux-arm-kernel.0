From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jan 2015 10:15:58 -0800
Subject: [PATCH 3/3] ARM: omap2plus_defconfig: Add NOR flash support
In-Reply-To: <1421691358-14661-1-git-send-email-tony@atomide.com>
References: <1421691358-14661-1-git-send-email-tony@atomide.com>
Message-ID: <1421691358-14661-4-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some omaps have NOR flash as the rootfs but we're missing
physmap and physmap_of to properly support it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3ac8269..6654b23 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -108,6 +108,8 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_OOPS=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
-- 
2.1.4
