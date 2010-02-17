From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Feb 2010 19:03:20 +0000
Subject: [PATCH 2/2] ARM: SMDK6410: Register IISv4 device
In-Reply-To: <1266433400-26780-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1266433400-26780-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1266433400-26780-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IISv4 controller is connected to the WM8580 on the board.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 297f1fa..6176243 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -255,6 +255,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
+	&s3c64xx_device_iisv4,
 
 #ifdef CONFIG_REGULATOR
 	&smdk6410_b_pwr_5v,
-- 
1.6.6.1
