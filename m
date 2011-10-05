From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:05:02 +0100
Subject: [PATCH 11/16] spi: pl022: Enable module alias autogeneration for AMBA
	drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-12-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/spi/spi-pl022.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f103e470..43abaf2 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2424,6 +2424,8 @@ static struct amba_id pl022_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl022_ids);
+
 static struct amba_driver pl022_driver = {
 	.drv = {
 		.name	= "ssp-pl022",
-- 
1.7.4.1
