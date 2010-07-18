From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sun, 18 Jul 2010 22:29:16 +0800
Subject: [PATCH] ARM/nuc900: add nuc900 kpi platform device structure to
	nuc910_dev
Message-ID: <4C430FBC.6010603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add nuc900 kpi platform device structure to nuc910_dev[],
which enables nuc910 keypad support.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/nuc910.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/nuc910.c b/arch/arm/mach-w90x900/nuc910.c
index cd49776..1523f41 100644
--- a/arch/arm/mach-w90x900/nuc910.c
+++ b/arch/arm/mach-w90x900/nuc910.c
@@ -27,6 +27,7 @@ static struct platform_device *nuc910_dev[] __initdata = {
 	&nuc900_device_ts,
 	&nuc900_device_rtc,
 	&nuc900_device_lcd,
+	&nuc900_device_kpi,
 };

 /* define specific CPU platform io map */
-- 
1.6.3.3
