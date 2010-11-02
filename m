From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  3 Nov 2010 00:51:54 +0100
Subject: [PATCH 17/17] ARM: pxa/colibri: setup pins for USB host port 3
In-Reply-To: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1288741914-21328-17-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Forsman <bjorn.forsman@gmail.com>

Tested on a Colibri Evaluation Board Rev.2.1 with a Colibri PXA310 module.

Signed-off-by: Bjorn Forsman <bjorn.forsman@gmail.com>
Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa300.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index b5bb248..fddb16d 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -46,6 +46,12 @@ static mfp_cfg_t colibri_pxa300_evalboard_pin_config[] __initdata = {
 	/* UHC */
 	GPIO0_2_USBH_PEN,
 	GPIO1_2_USBH_PWR,
+	GPIO77_USB_P3_1,
+	GPIO78_USB_P3_2,
+	GPIO79_USB_P3_3,
+	GPIO80_USB_P3_4,
+	GPIO81_USB_P3_5,
+	GPIO82_USB_P3_6,
 
 	/* I2C */
 	GPIO21_I2C_SCL,
-- 
1.7.2.3
