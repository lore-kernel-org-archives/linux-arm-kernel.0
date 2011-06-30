From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 30 Jun 2011 16:07:42 +0200
Subject: [PATCH 3/3] mach-realview: add TCM support for PB1176
Message-ID: <1309442862-4393-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Enable TCM support on the RealView PB1176 - we have now taken
the precautions necessary to support even multi-board builds of
RealView systems with TCM enabled.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index b9a9805..dba6d0c 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -50,6 +50,7 @@ config MACH_REALVIEW_PB1176
 	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
 	select CPU_V6
 	select ARM_GIC
+	select HAVE_TCM
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  ARM1176JZF-S.
-- 
1.7.3.2
