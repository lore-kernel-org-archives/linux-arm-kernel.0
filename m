From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:21:29 -0500
Subject: [PATCH 140/493] rtc: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-140-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Alessandro Zummo <a.zummo@towertech.it> 
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn> 
Cc: rtc-linux at googlegroups.com 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: uclinux-dist-devel at blackfin.uclinux.org 
Cc: patches at opensource.wolfsonmicro.com 
---
 drivers/rtc/rtc-88pm80x.c  | 2 +-
 drivers/rtc/rtc-88pm860x.c | 2 +-
 drivers/rtc/rtc-ab8500.c   | 2 +-
 drivers/rtc/rtc-at91sam9.c | 2 +-
 drivers/rtc/rtc-au1xxx.c   | 2 +-
 drivers/rtc/rtc-bfin.c     | 2 +-
 drivers/rtc/rtc-bq32k.c    | 2 +-
 drivers/rtc/rtc-bq4802.c   | 2 +-
 drivers/rtc/rtc-da9052.c   | 2 +-
 drivers/rtc/rtc-davinci.c  | 2 +-
 drivers/rtc/rtc-dm355evm.c | 2 +-
 drivers/rtc/rtc-ds1286.c   | 2 +-
 drivers/rtc/rtc-ds1302.c   | 2 +-
 drivers/rtc/rtc-ds1305.c   | 2 +-
 drivers/rtc/rtc-ds1307.c   | 2 +-
 drivers/rtc/rtc-ds1374.c   | 2 +-
 drivers/rtc/rtc-ds1390.c   | 2 +-
 drivers/rtc/rtc-ds1511.c   | 2 +-
 drivers/rtc/rtc-ds1553.c   | 2 +-
 drivers/rtc/rtc-ds1742.c   | 2 +-
 drivers/rtc/rtc-ds3232.c   | 2 +-
 drivers/rtc/rtc-ds3234.c   | 2 +-
 drivers/rtc/rtc-ep93xx.c   | 2 +-
 drivers/rtc/rtc-fm3130.c   | 2 +-
 drivers/rtc/rtc-imxdi.c    | 2 +-
 drivers/rtc/rtc-jz4740.c   | 2 +-
 drivers/rtc/rtc-lpc32xx.c  | 2 +-
 drivers/rtc/rtc-ls1x.c     | 2 +-
 drivers/rtc/rtc-m41t93.c   | 2 +-
 drivers/rtc/rtc-m41t94.c   | 2 +-
 drivers/rtc/rtc-m48t35.c   | 2 +-
 drivers/rtc/rtc-m48t59.c   | 2 +-
 drivers/rtc/rtc-m48t86.c   | 2 +-
 drivers/rtc/rtc-max6902.c  | 2 +-
 drivers/rtc/rtc-max8907.c  | 2 +-
 drivers/rtc/rtc-max8925.c  | 2 +-
 drivers/rtc/rtc-max8998.c  | 2 +-
 drivers/rtc/rtc-mpc5121.c  | 2 +-
 drivers/rtc/rtc-mrst.c     | 2 +-
 drivers/rtc/rtc-mxc.c      | 2 +-
 drivers/rtc/rtc-nuc900.c   | 2 +-
 drivers/rtc/rtc-pcap.c     | 2 +-
 drivers/rtc/rtc-pcf2123.c  | 2 +-
 drivers/rtc/rtc-pcf50633.c | 2 +-
 drivers/rtc/rtc-pcf8583.c  | 2 +-
 drivers/rtc/rtc-pm8xxx.c   | 2 +-
 drivers/rtc/rtc-puv3.c     | 2 +-
 drivers/rtc/rtc-r9701.c    | 2 +-
 drivers/rtc/rtc-rc5t583.c  | 2 +-
 drivers/rtc/rtc-rs5c313.c  | 2 +-
 drivers/rtc/rtc-rs5c348.c  | 2 +-
 drivers/rtc/rtc-rv3029c2.c | 2 +-
 drivers/rtc/rtc-rx8025.c   | 2 +-
 drivers/rtc/rtc-rx8581.c   | 2 +-
 drivers/rtc/rtc-s3c.c      | 2 +-
 drivers/rtc/rtc-snvs.c     | 2 +-
 drivers/rtc/rtc-spear.c    | 2 +-
 drivers/rtc/rtc-stk17ta8.c | 2 +-
 drivers/rtc/rtc-tegra.c    | 2 +-
 drivers/rtc/rtc-test.c     | 2 +-
 drivers/rtc/rtc-tile.c     | 2 +-
 drivers/rtc/rtc-tps65910.c | 2 +-
 drivers/rtc/rtc-twl.c      | 2 +-
 drivers/rtc/rtc-vr41xx.c   | 2 +-
 drivers/rtc/rtc-vt8500.c   | 2 +-
 drivers/rtc/rtc-wm831x.c   | 2 +-
 drivers/rtc/rtc-wm8350.c   | 2 +-
 67 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 6367984..ff18b41 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -358,7 +358,7 @@ static struct platform_driver pm80x_rtc_driver = {
 		   .pm = &pm80x_rtc_pm_ops,
 		   },
 	.probe = pm80x_rtc_probe,
-	.remove = __devexit_p(pm80x_rtc_remove),
+	.remove = pm80x_rtc_remove,
 };
 
 module_platform_driver(pm80x_rtc_driver);
diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index de9e854..4a71030 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -459,7 +459,7 @@ static struct platform_driver pm860x_rtc_driver = {
 		.pm	= &pm860x_rtc_pm_ops,
 	},
 	.probe		= pm860x_rtc_probe,
-	.remove		= __devexit_p(pm860x_rtc_remove),
+	.remove		= pm860x_rtc_remove,
 };
 
 module_platform_driver(pm860x_rtc_driver);
diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 2e5970f..c6bb392 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -468,7 +468,7 @@ static struct platform_driver ab8500_rtc_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe	= ab8500_rtc_probe,
-	.remove = __devexit_p(ab8500_rtc_remove),
+	.remove = ab8500_rtc_remove,
 };
 
 module_platform_driver(ab8500_rtc_driver);
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index e981798..9e0c630 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -463,7 +463,7 @@ static int at91_rtc_resume(struct platform_device *pdev)
 
 static struct platform_driver at91_rtc_driver = {
 	.probe		= at91_rtc_probe,
-	.remove		= __devexit_p(at91_rtc_remove),
+	.remove		= at91_rtc_remove,
 	.shutdown	= at91_rtc_shutdown,
 	.suspend	= at91_rtc_suspend,
 	.resume		= at91_rtc_resume,
diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
index 979ed04..42a340e 100644
--- a/drivers/rtc/rtc-au1xxx.c
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -131,7 +131,7 @@ static struct platform_driver au1xrtc_driver = {
 		.name	= "rtc-au1xxx",
 		.owner	= THIS_MODULE,
 	},
-	.remove		= __devexit_p(au1xtoy_rtc_remove),
+	.remove		= au1xtoy_rtc_remove,
 };
 
 static int __init au1xtoy_rtc_init(void)
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
index abfc1a0..92403a5 100644
--- a/drivers/rtc/rtc-bfin.c
+++ b/drivers/rtc/rtc-bfin.c
@@ -451,7 +451,7 @@ static struct platform_driver bfin_rtc_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= bfin_rtc_probe,
-	.remove		= __devexit_p(bfin_rtc_remove),
+	.remove		= bfin_rtc_remove,
 	.suspend	= bfin_rtc_suspend,
 	.resume		= bfin_rtc_resume,
 };
diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index f090159..1f02ba6 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -183,7 +183,7 @@ static struct i2c_driver bq32k_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= bq32k_probe,
-	.remove		= __devexit_p(bq32k_remove),
+	.remove		= bq32k_remove,
 	.id_table	= bq32k_id,
 };
 
diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index bf612ef..27d8225 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -215,7 +215,7 @@ static struct platform_driver bq4802_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= bq4802_probe,
-	.remove		= __devexit_p(bq4802_remove),
+	.remove		= bq4802_remove,
 };
 
 module_platform_driver(bq4802_driver);
diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
index 7807025..801c002 100644
--- a/drivers/rtc/rtc-da9052.c
+++ b/drivers/rtc/rtc-da9052.c
@@ -275,7 +275,7 @@ static int __devexit da9052_rtc_remove(struct platform_device *pdev)
 
 static struct platform_driver da9052_rtc_driver = {
 	.probe	= da9052_rtc_probe,
-	.remove	= __devexit_p(da9052_rtc_remove),
+	.remove	= da9052_rtc_remove,
 	.driver = {
 		.name	= "da9052-rtc",
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index 14c2109..7ffc240 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -596,7 +596,7 @@ static int __devexit davinci_rtc_remove(struct platform_device *pdev)
 
 static struct platform_driver davinci_rtc_driver = {
 	.probe		= davinci_rtc_probe,
-	.remove		= __devexit_p(davinci_rtc_remove),
+	.remove		= davinci_rtc_remove,
 	.driver		= {
 		.name = "rtc_davinci",
 		.owner = THIS_MODULE,
diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index d4457af..1896095 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -154,7 +154,7 @@ static int __devexit dm355evm_rtc_remove(struct platform_device *pdev)
  */
 static struct platform_driver rtc_dm355evm_driver = {
 	.probe		= dm355evm_rtc_probe,
-	.remove		= __devexit_p(dm355evm_rtc_remove),
+	.remove		= dm355evm_rtc_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "rtc-dm355evm",
diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index 990c3ff..9b0d2c6 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -393,7 +393,7 @@ static struct platform_driver ds1286_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ds1286_probe,
-	.remove		= __devexit_p(ds1286_remove),
+	.remove		= ds1286_remove,
 };
 
 module_platform_driver(ds1286_platform_driver);
diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index f0d6389..1f4e186 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -249,7 +249,7 @@ static struct platform_driver ds1302_platform_driver = {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
 	},
-	.remove		= __devexit_p(ds1302_rtc_remove),
+	.remove		= ds1302_rtc_remove,
 };
 
 static int __init ds1302_rtc_init(void)
diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 686a865..246dd80 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -810,7 +810,7 @@ static struct spi_driver ds1305_driver = {
 	.driver.name	= "rtc-ds1305",
 	.driver.owner	= THIS_MODULE,
 	.probe		= ds1305_probe,
-	.remove		= __devexit_p(ds1305_remove),
+	.remove		= ds1305_remove,
 	/* REVISIT add suspend/resume */
 };
 
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 836710c..42fb32b 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -963,7 +963,7 @@ static struct i2c_driver ds1307_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ds1307_probe,
-	.remove		= __devexit_p(ds1307_remove),
+	.remove		= ds1307_remove,
 	.id_table	= ds1307_id,
 };
 
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 9663160..039a676 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -442,7 +442,7 @@ static struct i2c_driver ds1374_driver = {
 		.pm = DS1374_PM,
 	},
 	.probe = ds1374_probe,
-	.remove = __devexit_p(ds1374_remove),
+	.remove = ds1374_remove,
 	.id_table = ds1374_id,
 };
 
diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index b0a99e1..db9b139 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -172,7 +172,7 @@ static struct spi_driver ds1390_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= ds1390_probe,
-	.remove = __devexit_p(ds1390_remove),
+	.remove = ds1390_remove,
 };
 
 module_spi_driver(ds1390_driver);
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 1f675f5..ae8da43 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -573,7 +573,7 @@ MODULE_ALIAS("platform:ds1511");
 
 static struct platform_driver ds1511_rtc_driver = {
 	.probe		= ds1511_rtc_probe,
-	.remove		= __devexit_p(ds1511_rtc_remove),
+	.remove		= ds1511_rtc_remove,
 	.driver		= {
 		.name	= "ds1511",
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 6ccedbb..188fa63 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -354,7 +354,7 @@ MODULE_ALIAS("platform:rtc-ds1553");
 
 static struct platform_driver ds1553_rtc_driver = {
 	.probe		= ds1553_rtc_probe,
-	.remove		= __devexit_p(ds1553_rtc_remove),
+	.remove		= ds1553_rtc_remove,
 	.driver		= {
 		.name	= "rtc-ds1553",
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 7611266..674808a 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -233,7 +233,7 @@ static int __devexit ds1742_rtc_remove(struct platform_device *pdev)
 
 static struct platform_driver ds1742_rtc_driver = {
 	.probe		= ds1742_rtc_probe,
-	.remove		= __devexit_p(ds1742_rtc_remove),
+	.remove		= ds1742_rtc_remove,
 	.driver		= {
 		.name	= "rtc-ds1742",
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index e194509..7824a39 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -469,7 +469,7 @@ static struct i2c_driver ds3232_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ds3232_probe,
-	.remove = __devexit_p(ds3232_remove),
+	.remove = ds3232_remove,
 	.id_table = ds3232_id,
 };
 
diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
index fda7079..10882bac 100644
--- a/drivers/rtc/rtc-ds3234.c
+++ b/drivers/rtc/rtc-ds3234.c
@@ -170,7 +170,7 @@ static struct spi_driver ds3234_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	 = ds3234_probe,
-	.remove = __devexit_p(ds3234_remove),
+	.remove = ds3234_remove,
 };
 
 module_spi_driver(ds3234_driver);
diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 9602278..5dc0f43 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -192,7 +192,7 @@ static struct platform_driver ep93xx_rtc_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ep93xx_rtc_probe,
-	.remove		= __devexit_p(ep93xx_rtc_remove),
+	.remove		= ep93xx_rtc_remove,
 };
 
 module_platform_driver(ep93xx_rtc_driver);
diff --git a/drivers/rtc/rtc-fm3130.c b/drivers/rtc/rtc-fm3130.c
index 86b6ecc..ac76078 100644
--- a/drivers/rtc/rtc-fm3130.c
+++ b/drivers/rtc/rtc-fm3130.c
@@ -561,7 +561,7 @@ static struct i2c_driver fm3130_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= fm3130_probe,
-	.remove		= __devexit_p(fm3130_remove),
+	.remove		= fm3130_remove,
 	.id_table	= fm3130_id,
 };
 
diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 18a4f0d..d4e4fab 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -511,7 +511,7 @@ static struct platform_driver dryice_rtc_driver = {
 		   .owner = THIS_MODULE,
 		   .of_match_table = of_match_ptr(dryice_dt_ids),
 		   },
-	.remove = __devexit_p(dryice_rtc_remove),
+	.remove = dryice_rtc_remove,
 };
 
 static int __init dryice_rtc_init(void)
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 1224182..d9b28f3 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -347,7 +347,7 @@ static const struct dev_pm_ops jz4740_pm_ops = {
 
 static struct platform_driver jz4740_rtc_driver = {
 	.probe	 = jz4740_rtc_probe,
-	.remove	 = __devexit_p(jz4740_rtc_remove),
+	.remove	 = jz4740_rtc_remove,
 	.driver	 = {
 		.name  = "jz4740-rtc",
 		.owner = THIS_MODULE,
diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index d521855..010f50a 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -397,7 +397,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_rtc_match);
 
 static struct platform_driver lpc32xx_rtc_driver = {
 	.probe		= lpc32xx_rtc_probe,
-	.remove		= __devexit_p(lpc32xx_rtc_remove),
+	.remove		= lpc32xx_rtc_remove,
 	.driver = {
 		.name	= RTC_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index 07e81c5..eac7cca 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -200,7 +200,7 @@ static struct platform_driver  ls1x_rtc_driver = {
 		.name	= "ls1x-rtc",
 		.owner	= THIS_MODULE,
 	},
-	.remove		= __devexit_p(ls1x_rtc_remove),
+	.remove		= ls1x_rtc_remove,
 	.probe		= ls1x_rtc_probe,
 };
 
diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index efab3d4..90ccaaf 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -211,7 +211,7 @@ static struct spi_driver m41t93_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= m41t93_probe,
-	.remove = __devexit_p(m41t93_remove),
+	.remove = m41t93_remove,
 };
 
 module_spi_driver(m41t93_driver);
diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
index 6e78193..94ed51f 100644
--- a/drivers/rtc/rtc-m41t94.c
+++ b/drivers/rtc/rtc-m41t94.c
@@ -150,7 +150,7 @@ static struct spi_driver m41t94_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= m41t94_probe,
-	.remove = __devexit_p(m41t94_remove),
+	.remove = m41t94_remove,
 };
 
 module_spi_driver(m41t94_driver);
diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
index f9e3b35..c3d5c14 100644
--- a/drivers/rtc/rtc-m48t35.c
+++ b/drivers/rtc/rtc-m48t35.c
@@ -213,7 +213,7 @@ static struct platform_driver m48t35_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= m48t35_probe,
-	.remove		= __devexit_p(m48t35_remove),
+	.remove		= m48t35_remove,
 };
 
 module_platform_driver(m48t35_platform_driver);
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 30ebfec..3a89eda 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -527,7 +527,7 @@ static struct platform_driver m48t59_rtc_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= m48t59_rtc_probe,
-	.remove		= __devexit_p(m48t59_rtc_remove),
+	.remove		= m48t59_rtc_remove,
 };
 
 module_platform_driver(m48t59_rtc_driver);
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 863fb33..d8f11e8 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -182,7 +182,7 @@ static struct platform_driver m48t86_rtc_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= m48t86_rtc_probe,
-	.remove		= __devexit_p(m48t86_rtc_remove),
+	.remove		= m48t86_rtc_remove,
 };
 
 module_platform_driver(m48t86_rtc_platform_driver);
diff --git a/drivers/rtc/rtc-max6902.c b/drivers/rtc/rtc-max6902.c
index 36c74d2..dea9a64 100644
--- a/drivers/rtc/rtc-max6902.c
+++ b/drivers/rtc/rtc-max6902.c
@@ -157,7 +157,7 @@ static struct spi_driver max6902_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= max6902_probe,
-	.remove = __devexit_p(max6902_remove),
+	.remove = max6902_remove,
 };
 
 module_spi_driver(max6902_driver);
diff --git a/drivers/rtc/rtc-max8907.c b/drivers/rtc/rtc-max8907.c
index e094ffa..d10cc5e 100644
--- a/drivers/rtc/rtc-max8907.c
+++ b/drivers/rtc/rtc-max8907.c
@@ -236,7 +236,7 @@ static struct platform_driver max8907_rtc_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = max8907_rtc_probe,
-	.remove = __devexit_p(max8907_rtc_remove),
+	.remove = max8907_rtc_remove,
 };
 module_platform_driver(max8907_rtc_driver);
 
diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index 34e4349..84307b4 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -334,7 +334,7 @@ static struct platform_driver max8925_rtc_driver = {
 		.pm     = &max8925_rtc_pm_ops,
 	},
 	.probe		= max8925_rtc_probe,
-	.remove		= __devexit_p(max8925_rtc_remove),
+	.remove		= max8925_rtc_remove,
 };
 
 module_platform_driver(max8925_rtc_driver);
diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index 7196f43..6b828c4 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -323,7 +323,7 @@ static struct platform_driver max8998_rtc_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= max8998_rtc_probe,
-	.remove		= __devexit_p(max8998_rtc_remove),
+	.remove		= max8998_rtc_remove,
 	.id_table	= max8998_rtc_id,
 };
 
diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index 029e421..151e7d3 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -416,7 +416,7 @@ static struct platform_driver mpc5121_rtc_driver = {
 		.of_match_table = mpc5121_rtc_match,
 	},
 	.probe = mpc5121_rtc_probe,
-	.remove = __devexit_p(mpc5121_rtc_remove),
+	.remove = mpc5121_rtc_remove,
 };
 
 module_platform_driver(mpc5121_rtc_driver);
diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index f51719b..77dda3d 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -528,7 +528,7 @@ MODULE_ALIAS("platform:vrtc_mrst");
 
 static struct platform_driver vrtc_mrst_platform_driver = {
 	.probe		= vrtc_mrst_platform_probe,
-	.remove		= __devexit_p(vrtc_mrst_platform_remove),
+	.remove		= vrtc_mrst_platform_remove,
 	.shutdown	= vrtc_mrst_platform_shutdown,
 	.driver = {
 		.name		= (char *) driver_name,
diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 7304139..5d03801 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -509,7 +509,7 @@ static struct platform_driver mxc_rtc_driver = {
 	},
 	.id_table = imx_rtc_devtype,
 	.probe = mxc_rtc_probe,
-	.remove = __devexit_p(mxc_rtc_remove),
+	.remove = mxc_rtc_remove,
 };
 
 module_platform_driver(mxc_rtc_driver)
diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index b7901098..5fa7adb 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -304,7 +304,7 @@ static int __devexit nuc900_rtc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver nuc900_rtc_driver = {
-	.remove		= __devexit_p(nuc900_rtc_remove),
+	.remove		= nuc900_rtc_remove,
 	.driver		= {
 		.name	= "nuc900-rtc",
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-pcap.c b/drivers/rtc/rtc-pcap.c
index cd4f198..a79dba6 100644
--- a/drivers/rtc/rtc-pcap.c
+++ b/drivers/rtc/rtc-pcap.c
@@ -196,7 +196,7 @@ static int __devexit pcap_rtc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver pcap_rtc_driver = {
-	.remove = __devexit_p(pcap_rtc_remove),
+	.remove = pcap_rtc_remove,
 	.driver = {
 		.name  = "pcap-rtc",
 		.owner = THIS_MODULE,
diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 13e4df6..bc481a9 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -345,7 +345,7 @@ static struct spi_driver pcf2123_driver = {
 			.owner	= THIS_MODULE,
 	},
 	.probe	= pcf2123_probe,
-	.remove	= __devexit_p(pcf2123_remove),
+	.remove	= pcf2123_remove,
 };
 
 module_spi_driver(pcf2123_driver);
diff --git a/drivers/rtc/rtc-pcf50633.c b/drivers/rtc/rtc-pcf50633.c
index a20202f..5122dad 100644
--- a/drivers/rtc/rtc-pcf50633.c
+++ b/drivers/rtc/rtc-pcf50633.c
@@ -291,7 +291,7 @@ static struct platform_driver pcf50633_rtc_driver = {
 		.name = "pcf50633-rtc",
 	},
 	.probe = pcf50633_rtc_probe,
-	.remove = __devexit_p(pcf50633_rtc_remove),
+	.remove = pcf50633_rtc_remove,
 };
 
 module_platform_driver(pcf50633_rtc_driver);
diff --git a/drivers/rtc/rtc-pcf8583.c b/drivers/rtc/rtc-pcf8583.c
index 019ff35..55c9766 100644
--- a/drivers/rtc/rtc-pcf8583.c
+++ b/drivers/rtc/rtc-pcf8583.c
@@ -316,7 +316,7 @@ static struct i2c_driver pcf8583_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pcf8583_probe,
-	.remove		= __devexit_p(pcf8583_remove),
+	.remove		= pcf8583_remove,
 	.id_table	= pcf8583_id,
 };
 
diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index d00bd24..fce198f 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -524,7 +524,7 @@ static SIMPLE_DEV_PM_OPS(pm8xxx_rtc_pm_ops, pm8xxx_rtc_suspend, pm8xxx_rtc_resum
 
 static struct platform_driver pm8xxx_rtc_driver = {
 	.probe		= pm8xxx_rtc_probe,
-	.remove		= __devexit_p(pm8xxx_rtc_remove),
+	.remove		= pm8xxx_rtc_remove,
 	.driver	= {
 		.name	= PM8XXX_RTC_DEV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index ab0acae..3414350 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -328,7 +328,7 @@ static int puv3_rtc_resume(struct platform_device *pdev)
 
 static struct platform_driver puv3_rtc_driver = {
 	.probe		= puv3_rtc_probe,
-	.remove		= __devexit_p(puv3_rtc_remove),
+	.remove		= puv3_rtc_remove,
 	.suspend	= puv3_rtc_suspend,
 	.resume		= puv3_rtc_resume,
 	.driver		= {
diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index 2c183eb..7293b8e 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -178,7 +178,7 @@ static struct spi_driver r9701_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= r9701_probe,
-	.remove = __devexit_p(r9701_remove),
+	.remove = r9701_remove,
 };
 
 module_spi_driver(r9701_driver);
diff --git a/drivers/rtc/rtc-rc5t583.c b/drivers/rtc/rtc-rc5t583.c
index cdb140c..5d43c4e 100644
--- a/drivers/rtc/rtc-rc5t583.c
+++ b/drivers/rtc/rtc-rc5t583.c
@@ -317,7 +317,7 @@ static const struct dev_pm_ops rc5t583_rtc_pm_ops = {
 
 static struct platform_driver rc5t583_rtc_driver = {
 	.probe		= rc5t583_rtc_probe,
-	.remove		= __devexit_p(rc5t583_rtc_remove),
+	.remove		= rc5t583_rtc_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "rtc-rc5t583",
diff --git a/drivers/rtc/rtc-rs5c313.c b/drivers/rtc/rtc-rs5c313.c
index e3ff179..ae3f9fd 100644
--- a/drivers/rtc/rtc-rs5c313.c
+++ b/drivers/rtc/rtc-rs5c313.c
@@ -392,7 +392,7 @@ static struct platform_driver rs5c313_rtc_platform_driver = {
 		.owner  = THIS_MODULE,
 	},
 	.probe 	= rs5c313_rtc_probe,
-	.remove = __devexit_p( rs5c313_rtc_remove ),
+	.remove =  rs5c313_rtc_remove ,
 };
 
 static int __init rs5c313_rtc_init(void)
diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index fd5c7af..4a8d0d4 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -235,7 +235,7 @@ static struct spi_driver rs5c348_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= rs5c348_probe,
-	.remove	= __devexit_p(rs5c348_remove),
+	.remove	= rs5c348_remove,
 };
 
 module_spi_driver(rs5c348_driver);
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 0fbe57b..fe6cabf 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -432,7 +432,7 @@ static struct i2c_driver rv3029c2_driver = {
 		.name = "rtc-rv3029c2",
 	},
 	.probe = rv3029c2_probe,
-	.remove = __devexit_p(rv3029c2_remove),
+	.remove = rv3029c2_remove,
 	.id_table = rv3029c2_id,
 };
 
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 0de902dc..ca28ce1 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -640,7 +640,7 @@ static struct i2c_driver rx8025_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= rx8025_probe,
-	.remove		= __devexit_p(rx8025_remove),
+	.remove		= rx8025_remove,
 	.id_table	= rx8025_id,
 };
 
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index d848251..64f33c1 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -272,7 +272,7 @@ static struct i2c_driver rx8581_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= rx8581_probe,
-	.remove		= __devexit_p(rx8581_remove),
+	.remove		= rx8581_remove,
 	.id_table	= rx8581_id,
 };
 
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 77823d2..2fc2aab 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -720,7 +720,7 @@ MODULE_DEVICE_TABLE(platform, s3c_rtc_driver_ids);
 
 static struct platform_driver s3c_rtc_driver = {
 	.probe		= s3c_rtc_probe,
-	.remove		= __devexit_p(s3c_rtc_remove),
+	.remove		= s3c_rtc_remove,
 	.suspend	= s3c_rtc_suspend,
 	.resume		= s3c_rtc_resume,
 	.id_table	= s3c_rtc_driver_ids,
diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 3c0da33..ee40be9 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -341,7 +341,7 @@ static struct platform_driver snvs_rtc_driver = {
 		.of_match_table = snvs_dt_ids,
 	},
 	.probe		= snvs_rtc_probe,
-	.remove		= __devexit_p(snvs_rtc_remove),
+	.remove		= snvs_rtc_remove,
 };
 module_platform_driver(snvs_rtc_driver);
 
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 141fc94..0b4763c 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -499,7 +499,7 @@ MODULE_DEVICE_TABLE(of, spear_rtc_id_table);
 
 static struct platform_driver spear_rtc_driver = {
 	.probe = spear_rtc_probe,
-	.remove = __devexit_p(spear_rtc_remove),
+	.remove = spear_rtc_remove,
 	.suspend = spear_rtc_suspend,
 	.resume = spear_rtc_resume,
 	.shutdown = spear_rtc_shutdown,
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index 279f5cf..c92c5d0 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -363,7 +363,7 @@ MODULE_ALIAS("platform:stk17ta8");
 
 static struct platform_driver stk17ta8_rtc_driver = {
 	.probe		= stk17ta8_rtc_probe,
-	.remove		= __devexit_p(stk17ta8_rtc_remove),
+	.remove		= stk17ta8_rtc_remove,
 	.driver		= {
 		.name	= "stk17ta8",
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index c006025..d88fa79 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -435,7 +435,7 @@ static void tegra_rtc_shutdown(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:tegra_rtc");
 static struct platform_driver tegra_rtc_driver = {
-	.remove		= __devexit_p(tegra_rtc_remove),
+	.remove		= tegra_rtc_remove,
 	.shutdown	= tegra_rtc_shutdown,
 	.driver		= {
 		.name	= "tegra_rtc",
diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 974b9ae..9b23e9f 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -131,7 +131,7 @@ static int __devexit test_remove(struct platform_device *plat_dev)
 
 static struct platform_driver test_driver = {
 	.probe	= test_probe,
-	.remove = __devexit_p(test_remove),
+	.remove = test_remove,
 	.driver = {
 		.name = "rtc-test",
 		.owner = THIS_MODULE,
diff --git a/drivers/rtc/rtc-tile.c b/drivers/rtc/rtc-tile.c
index eb65daf..91566a1 100644
--- a/drivers/rtc/rtc-tile.c
+++ b/drivers/rtc/rtc-tile.c
@@ -112,7 +112,7 @@ static struct platform_driver tile_rtc_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= tile_rtc_probe,
-	.remove		= __devexit_p(tile_rtc_remove),
+	.remove		= tile_rtc_remove,
 };
 
 /*
diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index 7a82337..8e412a7 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -335,7 +335,7 @@ static const struct dev_pm_ops tps65910_rtc_pm_ops = {
 
 static struct platform_driver tps65910_rtc_driver = {
 	.probe		= tps65910_rtc_probe,
-	.remove		= __devexit_p(tps65910_rtc_remove),
+	.remove		= tps65910_rtc_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "tps65910-rtc",
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 9277d94..80eee79 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -597,7 +597,7 @@ MODULE_ALIAS("platform:twl_rtc");
 
 static struct platform_driver twl4030rtc_driver = {
 	.probe		= twl_rtc_probe,
-	.remove		= __devexit_p(twl_rtc_remove),
+	.remove		= twl_rtc_remove,
 	.shutdown	= twl_rtc_shutdown,
 	.suspend	= twl_rtc_suspend,
 	.resume		= twl_rtc_resume,
diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 5f60a7c..9eef727 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -398,7 +398,7 @@ MODULE_ALIAS("platform:RTC");
 
 static struct platform_driver rtc_platform_driver = {
 	.probe		= rtc_probe,
-	.remove		= __devexit_p(rtc_remove),
+	.remove		= rtc_remove,
 	.driver		= {
 		.name	= rtc_name,
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index 14e2d8c..b9c9cf6 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -305,7 +305,7 @@ static const struct of_device_id wmt_dt_ids[] = {
 
 static struct platform_driver vt8500_rtc_driver = {
 	.probe		= vt8500_rtc_probe,
-	.remove		= __devexit_p(vt8500_rtc_remove),
+	.remove		= vt8500_rtc_remove,
 	.driver		= {
 		.name	= "vt8500-rtc",
 		.owner	= THIS_MODULE,
diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index ea5c6f8..f5955bb 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -483,7 +483,7 @@ static const struct dev_pm_ops wm831x_rtc_pm_ops = {
 
 static struct platform_driver wm831x_rtc_driver = {
 	.probe = wm831x_rtc_probe,
-	.remove = __devexit_p(wm831x_rtc_remove),
+	.remove = wm831x_rtc_remove,
 	.driver = {
 		.name = "wm831x-rtc",
 		.pm = &wm831x_rtc_pm_ops,
diff --git a/drivers/rtc/rtc-wm8350.c b/drivers/rtc/rtc-wm8350.c
index c2e52d1..c7ac9e2 100644
--- a/drivers/rtc/rtc-wm8350.c
+++ b/drivers/rtc/rtc-wm8350.c
@@ -479,7 +479,7 @@ static struct dev_pm_ops wm8350_rtc_pm_ops = {
 
 static struct platform_driver wm8350_rtc_driver = {
 	.probe = wm8350_rtc_probe,
-	.remove = __devexit_p(wm8350_rtc_remove),
+	.remove = wm8350_rtc_remove,
 	.driver = {
 		.name = "wm8350-rtc",
 		.pm = &wm8350_rtc_pm_ops,
-- 
1.8.0
