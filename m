From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 23 Dec 2009 21:44:11 +0800
Subject: [PATCH] NUC900: add timer 0-4 clk enabling definition
Message-ID: <4B321EAB.3080606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear sirs,

Li Jie, please re-make your previous patch relative to this.


Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/cpu.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 20dc0c9..1192424 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -61,6 +61,11 @@ static DEFINE_CLK(usbd, 8);
 static DEFINE_CLK(usbh, 9);
 static DEFINE_CLK(g2d, 10);;
 static DEFINE_CLK(pwm, 18);
+static DEFINE_CLK(timer0, 19);
+static DEFINE_CLK(timer1, 20);
+static DEFINE_CLK(timer2, 21);
+static DEFINE_CLK(timer3, 22);
+static DEFINE_CLK(timer4, 23);
 static DEFINE_CLK(ps2, 24);
 static DEFINE_CLK(kpi, 25);
 static DEFINE_CLK(wdt, 26);
@@ -90,6 +95,12 @@ static struct clk_lookup nuc900_clkregs[] = {
 	DEF_CLKLOOK(&clk_adc, "nuc900-adc", NULL),
 	DEF_CLKLOOK(&clk_usi, "nuc900-spi", NULL),
 	DEF_CLKLOOK(&clk_ext, NULL, "ext"),
+	DEF_CLKLOOK(&clk_timer0, NULL, "timer0"),
+	DEF_CLKLOOK(&clk_timer1, NULL, "timer1"),
+	DEF_CLKLOOK(&clk_timer2, NULL, "timer2"),
+	DEF_CLKLOOK(&clk_timer3, NULL, "timer3"),
+	DEF_CLKLOOK(&clk_timer4, NULL, "timer4"),
+
 };

 /* Initial serial platform data */
-- 
1.5.6.3
