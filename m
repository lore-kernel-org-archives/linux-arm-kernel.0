From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 12 May 2012 13:37:04 +0100
Subject: [PATCH 1/4] ARM: orion5x: ts78xx whitespace cleanups
In-Reply-To: <1336826227-17020-1-git-send-email-alex@digriz.org.uk>
References: <1336826227-17020-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1336826227-17020-2-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-fpga.h  |    6 +++---
 arch/arm/mach-orion5x/ts78xx-setup.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/ts78xx-fpga.h
index 151e89e..97c393d 100644
--- a/arch/arm/mach-orion5x/ts78xx-fpga.h
+++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
@@ -28,9 +28,9 @@ struct fpga_device {
 
 struct fpga_devices {
 	/* Technologic Systems */
-	struct fpga_device 	ts_rtc;
-	struct fpga_device 	ts_nand;
-	struct fpga_device 	ts_rng;
+	struct fpga_device	ts_rtc;
+	struct fpga_device	ts_nand;
+	struct fpga_device	ts_rng;
 };
 
 struct ts78xx_fpga_data {
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index c96f374..c41f27b 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -115,7 +115,7 @@ static struct platform_device ts78xx_ts_rtc_device = {
  * I've used the method TS use in their rtc7800.c example for the detection
  *
  * TODO: track down a guinea pig without an RTC to see if we can work out a
- * 		better RTC detection routine
+ *		better RTC detection routine
  */
 static int ts78xx_ts_rtc_load(void)
 {
-- 
1.7.10
