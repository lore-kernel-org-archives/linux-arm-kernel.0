From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:05:04 +0100
Subject: [PATCH 13/16] serial: pl011: Enable module alias autogeneration for
	AMBA drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-14-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 00233af..6958594 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1994,6 +1994,8 @@ static struct amba_id pl011_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl011_ids);
+
 static struct amba_driver pl011_driver = {
 	.drv = {
 		.name	= "uart-pl011",
-- 
1.7.4.1
