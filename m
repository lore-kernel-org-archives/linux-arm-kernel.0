From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:05:03 +0100
Subject: [PATCH 12/16] serial: pl010: Enable module alias autogeneration for
	AMBA drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-13-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/tty/serial/amba-pl010.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index efdf92c..0d91a54 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -795,6 +795,8 @@ static struct amba_id pl010_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl010_ids);
+
 static struct amba_driver pl010_driver = {
 	.drv = {
 		.name	= "uart-pl010",
-- 
1.7.4.1
