From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 15:22:57 +0200
Subject: [PATCH 16/16] ARM: mvebu: defconfig: Enable CPU Idle support in
 mvebu_v7_defconfig
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403875377-940-17-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mvebu SoCs such as Armada 370, Armada XP or Armada 38x now support CPU
Idle so let's add it in the default configuration.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index e11170e37442..b174072cabd8 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -28,6 +28,8 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_MVEBU_V7_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_INET=y
-- 
1.8.1.2
