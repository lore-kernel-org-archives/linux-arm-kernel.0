From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Mar 2014 23:38:56 +0100
Subject: [PATCH] ARM: mvebu: Enable NEON support in defconfig
Message-ID: <1395268736-13338-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_NEON is no more turning on unconditionally when Armada 375 or
Armada 38x are selected. However we still want it selected for the
reference configuration.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 62b6a37626c5..36797dbfa610 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -26,6 +26,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
+CONFIG_NEON=y
 CONFIG_NET=y
 CONFIG_INET=y
 CONFIG_BT=y
-- 
1.8.1.2
