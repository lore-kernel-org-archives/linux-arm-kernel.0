From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 13 Oct 2016 16:32:08 -0500
Subject: [PATCH 3/4] mfd: altr-a10sr: Add Arria10 SR Monitor
In-Reply-To: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
References: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1476394329-31696-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the Altera Arria10 DevKit System Resource Monitor functionality
to the MFD device.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/mfd/altera-a10sr.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index 06e1f7f..0942d7d 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -33,6 +33,10 @@
 		.name = "altr_a10sr_gpio",
 		.of_compatible = "altr,a10sr-gpio",
 	},
+	{
+		.name = "altr_a10sr_mon",
+		.of_compatible = "altr,a10sr-mon",
+	},
 };
 
 static bool altr_a10sr_reg_readable(struct device *dev, unsigned int reg)
-- 
1.7.9.5
