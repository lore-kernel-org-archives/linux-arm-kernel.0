From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 21:54:20 +0800
Subject: [PATCH v3 4/8] ARM: multi_v7_defconfig: enable INFRACFG and SCPSYS
 modules
In-Reply-To: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1438696464-59858-5-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The INFRACFG contains various infrastructure registers and the SCPSYS handles
several power management related tasks. Both are needed for SMP and CPU
hotplug on MT6580.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d83a1b..c272edd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -596,6 +596,8 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
+CONFIG_MTK_INFRACFG=y
+CONFIG_MTK_SCPSYS=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
 CONFIG_COMMON_CLK_QCOM=y
-- 
1.7.9.5
