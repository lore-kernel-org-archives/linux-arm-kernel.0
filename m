From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 20 Jan 2010 03:48:50 +0000
Subject: [PATCH] ARM: SAMSUNG: Move more support into plat-samsung
In-Reply-To: <1263959332-6264-1-git-send-email-ben-linux@fluff.org>
References: <1263959332-6264-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263959332-6264-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move header files which are not likely to be touched in
any further support addition out of plat-s3c's include
directory into plat-samsung.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 .../include/plat => plat-samsung}/dma-core.h       |    0
 .../include/plat/hwmon.h                           |    0
 .../include/plat/iic-core.h                        |    0
 .../{plat-s3c => plat-samsung}/include/plat/iic.h  |    0
 .../{plat-s3c => plat-samsung}/include/plat/nand.h |    0
 .../include/plat/regs-ac97.h                       |    0
 .../include/plat/regs-adc.h                        |    0
 .../include/plat/regs-iic.h                        |    0
 .../include/plat/regs-irqtype.h                    |    0
 .../include/plat/regs-nand.h                       |    0
 .../include/plat/regs-rtc.h                        |    0
 .../include/plat/regs-s3c2412-iis.h                |    0
 .../include/plat/regs-sdhci.h                      |    0
 .../include/plat/regs-timer.h                      |    0
 .../include/plat/regs-usb-hsotg-phy.h              |    0
 .../include/plat/regs-usb-hsotg.h                  |    0
 .../include/plat/regs-watchdog.h                   |    0
 .../include/plat/sdhci.h                           |    0
 .../include/plat/udc-hs.h                          |    0
 .../include/plat/watchdog-reset.h                  |    0
 20 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/{plat-s3c/include/plat => plat-samsung}/dma-core.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/hwmon.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/iic-core.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/iic.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/nand.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-ac97.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-adc.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-iic.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-irqtype.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-nand.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-rtc.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-s3c2412-iis.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-sdhci.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-timer.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-usb-hsotg-phy.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-usb-hsotg.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-watchdog.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/sdhci.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/udc-hs.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/watchdog-reset.h (100%)

diff --git a/arch/arm/plat-s3c/include/plat/dma-core.h b/arch/arm/plat-samsung/dma-core.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/dma-core.h
rename to arch/arm/plat-samsung/dma-core.h
diff --git a/arch/arm/plat-s3c/include/plat/hwmon.h b/arch/arm/plat-samsung/include/plat/hwmon.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/hwmon.h
rename to arch/arm/plat-samsung/include/plat/hwmon.h
diff --git a/arch/arm/plat-s3c/include/plat/iic-core.h b/arch/arm/plat-samsung/include/plat/iic-core.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/iic-core.h
rename to arch/arm/plat-samsung/include/plat/iic-core.h
diff --git a/arch/arm/plat-s3c/include/plat/iic.h b/arch/arm/plat-samsung/include/plat/iic.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/iic.h
rename to arch/arm/plat-samsung/include/plat/iic.h
diff --git a/arch/arm/plat-s3c/include/plat/nand.h b/arch/arm/plat-samsung/include/plat/nand.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/nand.h
rename to arch/arm/plat-samsung/include/plat/nand.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-ac97.h b/arch/arm/plat-samsung/include/plat/regs-ac97.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-ac97.h
rename to arch/arm/plat-samsung/include/plat/regs-ac97.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-adc.h b/arch/arm/plat-samsung/include/plat/regs-adc.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-adc.h
rename to arch/arm/plat-samsung/include/plat/regs-adc.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-iic.h b/arch/arm/plat-samsung/include/plat/regs-iic.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-iic.h
rename to arch/arm/plat-samsung/include/plat/regs-iic.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-irqtype.h b/arch/arm/plat-samsung/include/plat/regs-irqtype.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-irqtype.h
rename to arch/arm/plat-samsung/include/plat/regs-irqtype.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-nand.h b/arch/arm/plat-samsung/include/plat/regs-nand.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-nand.h
rename to arch/arm/plat-samsung/include/plat/regs-nand.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-rtc.h b/arch/arm/plat-samsung/include/plat/regs-rtc.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-rtc.h
rename to arch/arm/plat-samsung/include/plat/regs-rtc.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h b/arch/arm/plat-samsung/include/plat/regs-s3c2412-iis.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
rename to arch/arm/plat-samsung/include/plat/regs-s3c2412-iis.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-sdhci.h b/arch/arm/plat-samsung/include/plat/regs-sdhci.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-sdhci.h
rename to arch/arm/plat-samsung/include/plat/regs-sdhci.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-timer.h b/arch/arm/plat-samsung/include/plat/regs-timer.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-timer.h
rename to arch/arm/plat-samsung/include/plat/regs-timer.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-usb-hsotg-phy.h b/arch/arm/plat-samsung/include/plat/regs-usb-hsotg-phy.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-usb-hsotg-phy.h
rename to arch/arm/plat-samsung/include/plat/regs-usb-hsotg-phy.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-usb-hsotg.h b/arch/arm/plat-samsung/include/plat/regs-usb-hsotg.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-usb-hsotg.h
rename to arch/arm/plat-samsung/include/plat/regs-usb-hsotg.h
diff --git a/arch/arm/plat-s3c/include/plat/regs-watchdog.h b/arch/arm/plat-samsung/include/plat/regs-watchdog.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/regs-watchdog.h
rename to arch/arm/plat-samsung/include/plat/regs-watchdog.h
diff --git a/arch/arm/plat-s3c/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/sdhci.h
rename to arch/arm/plat-samsung/include/plat/sdhci.h
diff --git a/arch/arm/plat-s3c/include/plat/udc-hs.h b/arch/arm/plat-samsung/include/plat/udc-hs.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/udc-hs.h
rename to arch/arm/plat-samsung/include/plat/udc-hs.h
diff --git a/arch/arm/plat-s3c/include/plat/watchdog-reset.h b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
similarity index 100%
rename from arch/arm/plat-s3c/include/plat/watchdog-reset.h
rename to arch/arm/plat-samsung/include/plat/watchdog-reset.h
-- 
1.6.0.4
