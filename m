From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 30 Oct 2013 23:56:03 +0000
Subject: [PATCH] thermal: imx_thermal: add module device table
Message-ID: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the module device table declaration so the module can be loaded
automatically at boot time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/thermal/imx_thermal.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1d6c801c1eb9..ab31552f0360 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -539,3 +539,4 @@ MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:imx-thermal");
+MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
-- 
1.7.4.4
