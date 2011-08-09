From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 9 Aug 2011 21:41:38 +0200
Subject: [PATCH 3/5] mach-u300: patch physoffset by default
Message-ID: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This works like a charm so I'll just default-select it.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c71a8f..14bfd8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -831,6 +831,7 @@ config ARCH_U300
 	select HAVE_SCHED_CLOCK
 	select HAVE_TCM
 	select ARM_AMBA
+	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
-- 
1.7.3.2
