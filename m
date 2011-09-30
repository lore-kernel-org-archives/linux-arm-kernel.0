From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 30 Sep 2011 17:56:42 +0100
Subject: [RFC PATCH 3/3] ARM: drivers/mmc/host/mmci.c: Define amba module alias
In-Reply-To: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
References: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317401802-24362-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/mmc/host/mmci.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 56e9a41..ea2a72c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1477,6 +1477,14 @@ static struct amba_id mmci_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_ALIAS("amba:00?41180");
+MODULE_ALIAS("amba:01?41180");
+MODULE_ALIAS("amba:???41181");
+MODULE_ALIAS("amba:??180180");
+MODULE_ALIAS("amba:??280180");
+MODULE_ALIAS("amba:0?480180");
+MODULE_ALIAS("amba:1?480180");
+
 static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
-- 
1.7.4.1
