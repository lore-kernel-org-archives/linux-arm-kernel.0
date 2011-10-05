From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:04:59 +0100
Subject: [PATCH 08/16] mmc: mmci: Enable module alias autogeneration for AMBA
	drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-9-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/mmc/host/mmci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b16ea4a..a7d398c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1496,6 +1496,8 @@ static struct amba_id mmci_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, mmci_ids);
+
 static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
-- 
1.7.4.1
