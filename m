From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Nov 2009 16:43:59 +0000
Subject: [PATCH 7/7] SMDK6410: Register IISv4 device
In-Reply-To: <20091127164312.GA11913@rakim.wolfsonmicro.main>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
Message-ID: <1259340239-12067-7-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IISv4 controller is connected to the WM8580 on the board.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 480d297..52d431c 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -236,6 +236,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_usb,
 	&s3c_device_usb_hsotg,
+	&s3c64xx_device_iisv4,
 
 #ifdef CONFIG_REGULATOR
 	&smdk6410_b_pwr_5v,
-- 
1.6.5.3
