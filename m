From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 30 Jan 2014 13:23:51 -0800
Subject: [PATCH] ARM: msm_defconfig: Change CONFIG_CC_STACKPROTECTOR
Message-ID: <1391117031-8131-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_CC_STACKPROTECTOR is no longer the option to select.
Switch to CONFIG_CC_STACKPROTECTOR_REGULAR.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/configs/msm_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index 0219c65..d61d5bb 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -12,6 +12,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_KPROBES=y
+CONFIG_CC_STACKPROTECTOR_REGULAR=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -27,7 +28,6 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_HIGHPTE=y
 CONFIG_CLEANCACHE=y
-CONFIG_CC_STACKPROTECTOR=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
