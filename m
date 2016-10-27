From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 27 Oct 2016 15:00:25 -0500
Subject: [PATCHv2 3/4] mfd: altr-a10sr: Add Arria10 SR Monitor
In-Reply-To: <1477598426-28125-1-git-send-email-tthayer@opensource.altera.com>
References: <1477598426-28125-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1477598426-28125-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the Altera Arria10 DevKit System Resource Monitor functionality
to the MFD device.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  Change from -mon to -monitor for clarity
---
 drivers/mfd/altera-a10sr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index 06e1f7f..30de652 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -33,6 +33,10 @@
 		.name = "altr_a10sr_gpio",
 		.of_compatible = "altr,a10sr-gpio",
 	},
+	{
+		.name = "altr_a10sr_monitor",
+		.of_compatible = "altr,a10sr-monitor",
+	},
 };
 
 static bool altr_a10sr_reg_readable(struct device *dev, unsigned int reg)
-- 
1.9.1
