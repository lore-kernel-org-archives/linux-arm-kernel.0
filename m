From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 15 Feb 2017 15:50:15 -0600
Subject: [PATCH 4/5] mfd: altr_a10sr: Add Arria10 DevKit Resource Controller
In-Reply-To: <1487195416-23827-1-git-send-email-thor.thayer@linux.intel.com>
References: <1487195416-23827-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1487195416-23827-5-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add Arria10 System Resource Manager Reset Controller to MFD.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/mfd/altera-a10sr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index 06e1f7f..96e7d2c 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -33,6 +33,10 @@
 		.name = "altr_a10sr_gpio",
 		.of_compatible = "altr,a10sr-gpio",
 	},
+	{
+		.name = "altr_a10sr_reset",
+		.of_compatible = "altr,a10sr-reset",
+	},
 };
 
 static bool altr_a10sr_reg_readable(struct device *dev, unsigned int reg)
-- 
1.9.1
