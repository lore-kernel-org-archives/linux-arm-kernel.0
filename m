From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Oct 2012 11:30:09 +0100
Subject: [PATCH 2/3] spi: spidev: Add Rohm DH2228FV DAC compatible string
In-Reply-To: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1351679410-11026-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we don't have a driver for it yet, use spidev instead.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/spi/spidev.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9fc5788..e44abc9 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -645,6 +645,7 @@ static int __devexit spidev_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id spidev_dt_ids[] = {
+	{ .compatible = "rohm,dh2228fv" },
 	{},
 };
 
-- 
1.7.9.5
