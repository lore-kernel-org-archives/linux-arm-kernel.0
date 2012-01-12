From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Thu, 12 Jan 2012 11:07:43 +0530
Subject: [PATCH 2/2] mach-ux500: enable ARM errata 764369
In-Reply-To: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
References: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
Message-ID: <1326346663-6112-2-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This applies ARM errata 764369 for all ux500 platforms.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index a3e0c86..52af004 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -7,6 +7,7 @@ config UX500_SOC_COMMON
 	select HAS_MTU
 	select ARM_ERRATA_753970
 	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369
 
 menu "Ux500 SoC"
 
-- 
1.7.4.3
