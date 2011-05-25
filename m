From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 May 2011 21:55:39 +0800
Subject: [PATCH 2/2] ARM: mxs_defconfig: Add mx23evk and mx28evk build
In-Reply-To: <1306331739-8241-1-git-send-email-shawn.guo@linaro.org>
References: <1306331739-8241-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1306331739-8241-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds following configurations to enable build of mx23evk
and mx28evk in defconfig.

  CONFIG_MACH_MX23EVK
  CONFIG_MACH_MX28EVK

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 5a6ff7c..db2cb7d 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -22,6 +22,8 @@ CONFIG_BLK_DEV_INTEGRITY=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MXS=y
+CONFIG_MACH_MX23EVK=y
+CONFIG_MACH_MX28EVK=y
 CONFIG_MACH_STMP378X_DEVB=y
 CONFIG_MACH_TX28=y
 # CONFIG_ARM_THUMB is not set
-- 
1.7.4.1
