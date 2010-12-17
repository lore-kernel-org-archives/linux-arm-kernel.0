From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:05 +0900
Subject: [PATCH 03/17] ARM: SMDK6442: Enable I2S device to work
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562005-19684-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add missing virtual ASoC DMA device.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/mach-smdk6442.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index e69f137..eaf6b9c 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -68,6 +68,7 @@ static struct s3c2410_uartcfg smdk6442_uartcfgs[] __initdata = {
 
 static struct platform_device *smdk6442_devices[] __initdata = {
 	&s3c_device_i2c0,
+	&samsung_asoc_dma,
 	&s5p6442_device_iis0,
 	&s3c_device_wdt,
 };
-- 
1.6.2.5
