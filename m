From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Jul 2014 16:51:41 +0200
Subject: [PATCHv2 7/8] ARM: mvebu: update mvebu_v7_defconfig with cpufreq
 support
In-Reply-To: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404744702-32010-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Armada XP supports dynamic CPU frequency scaling, it
makes sense to enable the cpufreq subsystem in mvebu_v7_defconfig, as
well as the cpufreq-generic driver used on Armada XP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index b0bfefa..be2b5bc 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -29,6 +29,8 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_GENERIC=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_INET=y
-- 
2.0.0
