From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Jan 2013 15:00:56 +0900
Subject: [PATCH] ARM: mach-shmobile: mackerel:  enable VFP in defconfig
Message-ID: <1358920856-32256-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_VFP appears to be required to use the
Debian armhf userspace. Enabling this is consistent
with many other shmobile boards.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/mackerel_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index e6881ac..7594b3a 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -25,6 +25,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_KEXEC=y
+CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM=y
 CONFIG_PM_RUNTIME=y
-- 
1.7.10.4
