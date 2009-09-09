From: laforge@gnumonks.org (laforge at gnumonks.org)
Date: Wed,  9 Sep 2009 20:07:32 +0900
Subject: [PATCH 3/3] [ARM] Enable watchdog platform device on SMDK6410
Message-ID: <1252494452-7356-1-git-send-email-laforge@gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harald Welte <laforge@gnumonks.org>

This patch adds watchdog in the list of platform devices for Samsung's
6410 SoC.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index bc9a7de..fafffce 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -184,6 +184,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_usb,
 	&s3c_device_usb_hsotg,
+	&s3c_device_wdt,
 	&smdk6410_lcd_powerdev,
 
 	&smdk6410_smsc911x,
-- 
1.5.3.4
