From: scott.shu@mediatek.com (Scott Shu)
Date: Sun, 23 Aug 2015 17:01:03 +0800
Subject: [PATCH v4 4/8] ARM: multi_v7_defconfig: enable INFRACFG and SCPSYS
 modules
In-Reply-To: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
References: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1440320467-26118-5-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The INFRACFG contains various infrastructure registers and the SCPSYS handles
several power management related tasks. Both are needed for SMP and CPU
hotplug on MT6580.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
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
1.9.1

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
