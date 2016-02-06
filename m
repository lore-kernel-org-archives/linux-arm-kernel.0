From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat,  6 Feb 2016 11:03:46 -0700
Subject: [PATCH 3/3] ARM: bcm2835_defconfig: enable ARMv7 support
In-Reply-To: <1454781826-10571-1-git-send-email-swarren@wwwdotorg.org>
References: <1454781826-10571-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1454781826-10571-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the RPi2 work; it has an ARMv7 CPU.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 4a1fb17eebf6..7c20a0bc2722 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -26,7 +26,6 @@ CONFIG_OPROFILE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_CC_STACKPROTECTOR_REGULAR=y
 CONFIG_ARCH_MULTI_V6=y
-# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_PREEMPT_VOLUNTARY=y
-- 
1.9.1
