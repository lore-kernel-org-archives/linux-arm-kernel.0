From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Dec 2011 23:40:24 +0100
Subject: [PATCH 2/2] ARM: activate TCM on the Integrator
Message-ID: <1323297624-22901-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Integrator core modules have TCM memory, so let's turn it on
if it's there.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e084b7e..d9a4485 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -257,6 +257,7 @@ config ARCH_INTEGRATOR
 	select ARCH_HAS_CPUFREQ
 	select CLKDEV_LOOKUP
 	select HAVE_MACH_CLKDEV
+	select HAVE_TCM
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
-- 
1.7.6.4
