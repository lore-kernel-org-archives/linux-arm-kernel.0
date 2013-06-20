From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Jun 2013 13:54:10 +0200
Subject: [PATCH] ARM: nomadik: configure for NO_HZ and HRTIMERS
Message-ID: <1371729250-30557-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables tickless idle (NO_HZ_IDLE) and high resolution
timers for the Nomadik.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/nhk8815_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index e4cb5a4..263ae38 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -1,6 +1,8 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-- 
1.8.1.4
