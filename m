From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:35 +0200
Subject: [PATCH 22/24] ARM: ux500: Enable Kconfig for the generic power domain
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-23-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ux500 uses genpd, this will enable the power domain support.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index b41a42d..aaf8cfd 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -33,6 +33,7 @@ config UX500_SOC_DB8500
 	select PINCTRL_AB8540
 	select REGULATOR
 	select REGULATOR_DB8500_PRCMU
+	select PM_GENERIC_DOMAINS if PM
 
 menu "Ux500 target platform (boards)"
 
-- 
1.7.9.5
