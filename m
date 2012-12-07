From: marex@denx.de (Marek Vasut)
Date: Fri,  7 Dec 2012 16:24:51 +0100
Subject: [PATCH 2/4] iio: mxs: Remove unused fields from mxs_lradc
In-Reply-To: <1354893893-26338-1-git-send-email-marex@denx.de>
References: <1354893893-26338-1-git-send-email-marex@denx.de>
Message-ID: <1354893893-26338-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused "enable" field from struct mxs_lradc. This seems to be
remnant of early development.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/staging/iio/adc/mxs-lradc.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 67abf50..6249957 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -85,8 +85,6 @@ struct mxs_lradc {
 
 	struct mutex		lock;
 
-	uint8_t			enable;
-
 	struct completion	completion;
 };
 
-- 
1.7.10.4
