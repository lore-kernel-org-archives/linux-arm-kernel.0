From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 11:22:36 +0200
Subject: [PATCH RESEND 04/12] mmc: sdhci-pxav3: Remove unused clk_enable from
 sdhci_pxa
In-Reply-To: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413883364-681-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_enable from struct sdhci_pxa is unused, remove it from the private
driver data.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: linux-mmc at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/mmc/host/sdhci-pxav3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 48bc8179c8fc..d1f63d32b2cd 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -59,7 +59,6 @@
 #define SDCE_MISC_INT_EN	(1<<1)
 
 struct sdhci_pxa {
-	u8	clk_enable;
 	u8	power_mode;
 };
 
-- 
2.1.1
