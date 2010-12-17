From: jhnikula@gmail.com (Jarkko Nikula)
Date: Fri, 17 Dec 2010 21:18:24 +0200
Subject: [PATCH 2/3] omap: rx51: Remove extra tlv320aic3x.h inclusion
In-Reply-To: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
References: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1292613505-10113-2-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove second tlv320aic3x.h inclusion that came along the commit f0fba2a
"ASoC: multi-component - ASoC Multi-Component Support".

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
Clearly for 2.6.38 as harmless issue.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index cde6847..6114e47 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -23,7 +23,6 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
-#include <sound/tlv320aic3x.h>
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
-- 
1.7.2.3
