From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 09 Aug 2011 09:07:21 +0100
Subject: [PATCH 09/13] ARM: gpio: tegra: convert drivers to use asm/gpio.h
	rather than mach/gpio.h
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Message-ID: <E1QqhLN-0003aX-Lg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 18b0bd3..e9094f1 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -21,7 +21,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/sdhci.h>
 
 #include "sdhci-pltfm.h"
-- 
1.7.4.4
