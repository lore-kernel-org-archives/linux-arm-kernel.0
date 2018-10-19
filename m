From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2018 11:24:26 +0200
Subject: [PATCH] ARM: defconfig: Update multi_v7 to use PREEMPT
Message-ID: <20181019092426.12052-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using CONFIG_PREEMPT as preemption model for ARMv7 systems
appear to be the most reasonable default.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC folks, if you agree with this patch, please
just apply it where and when appropriate.
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444e94f0..a5d184779709 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,6 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
-- 
2.17.2
