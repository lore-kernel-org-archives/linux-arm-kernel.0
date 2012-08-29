From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:31 -0500
Subject: [PATCH 05/10] ARM: at91: explicitly include mach/gpio.h
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add explict
include of mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c  |    1 +
 arch/arm/mach-at91/at91sam9260_devices.c |    1 +
 arch/arm/mach-at91/at91sam9261_devices.c |    1 +
 arch/arm/mach-at91/at91sam9263_devices.c |    1 +
 arch/arm/mach-at91/at91sam9g45_devices.c |    1 +
 arch/arm/mach-at91/at91sam9rl_devices.c  |    1 +
 arch/arm/mach-at91/board-1arm.c          |    1 +
 arch/arm/mach-at91/board-afeb-9260v1.c   |    1 +
 arch/arm/mach-at91/board-cam60.c         |    1 +
 arch/arm/mach-at91/board-carmeva.c       |    1 +
 arch/arm/mach-at91/board-cpu9krea.c      |    1 +
 arch/arm/mach-at91/board-cpuat91.c       |    1 +
 arch/arm/mach-at91/board-csb337.c        |    1 +
 arch/arm/mach-at91/board-csb637.c        |    1 +
 arch/arm/mach-at91/board-eb9200.c        |    1 +
 arch/arm/mach-at91/board-ecbat91.c       |    1 +
 arch/arm/mach-at91/board-eco920.c        |    1 +
 arch/arm/mach-at91/board-flexibity.c     |    1 +
 arch/arm/mach-at91/board-foxg20.c        |    1 +
 arch/arm/mach-at91/board-gsia18s.c       |    1 +
 arch/arm/mach-at91/board-kafa.c          |    1 +
 arch/arm/mach-at91/board-kb9202.c        |    1 +
 arch/arm/mach-at91/board-neocore926.c    |    1 +
 arch/arm/mach-at91/board-pcontrol-g20.c  |    1 +
 arch/arm/mach-at91/board-picotux200.c    |    1 +
 arch/arm/mach-at91/board-qil-a9260.c     |    1 +
 arch/arm/mach-at91/board-rm9200dk.c      |    1 +
 arch/arm/mach-at91/board-rm9200ek.c      |    1 +
 arch/arm/mach-at91/board-rsi-ews.c       |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c    |    1 +
 arch/arm/mach-at91/board-sam9260ek.c     |    1 +
 arch/arm/mach-at91/board-sam9261ek.c     |    1 +
 arch/arm/mach-at91/board-sam9263ek.c     |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c     |    1 +
 arch/arm/mach-at91/board-sam9m10g45ek.c  |    1 +
 arch/arm/mach-at91/board-sam9rlek.c      |    1 +
 arch/arm/mach-at91/board-snapper9260.c   |    1 +
 arch/arm/mach-at91/board-stamp9g20.c     |    1 +
 arch/arm/mach-at91/board-usb-a926x.c     |    1 +
 arch/arm/mach-at91/board-yl-9200.c       |    1 +
 arch/arm/mach-at91/gpio.c                |    1 +
 arch/arm/mach-at91/leds.c                |    1 +
 arch/arm/mach-at91/pm.c                  |    1 +
 43 files changed, 43 insertions(+)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 01fb732..8b15739 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -22,6 +22,7 @@
 #include <mach/at91rm9200.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 7b9c2ba..2b6caf3 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -26,6 +26,7 @@
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_adc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 8df5c1b..e79d7b4 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -26,6 +26,7 @@
 #include <mach/at91sam9261_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index eb6bbf8..4a58359 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -25,6 +25,7 @@
 #include <mach/at91sam9263_matrix.h>
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 0607399..799861f 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -33,6 +33,7 @@
 #include <mach/at91sam9_smc.h>
 #include <mach/at_hdmac.h>
 #include <mach/atmel-mci.h>
+#include <mach/gpio.h>
 
 #include <media/atmel-isi.h>
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index f09fff9..ca6abdd 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -23,6 +23,7 @@
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at_hdmac.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 22d8856..bbd9f05 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -37,6 +37,7 @@
 #include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index de7be19..4d09924 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -45,6 +45,7 @@
 
 #include <mach/board.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 477e708..bec435c 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -41,6 +41,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index a5b002f..685a170 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -37,6 +37,7 @@
 #include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index ecbc13b..1d05046 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -45,6 +45,7 @@
 #include <mach/at91sam9_smc.h>
 #include <mach/at91sam9260_matrix.h>
 #include <mach/at91_matrix.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2e6d043..cfa39e9 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -41,6 +41,7 @@
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 462bc31..59741c1 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -40,6 +40,7 @@
 #include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 872871a..e36c63c 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -37,6 +37,7 @@
 #include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index d1e1f3f..8816928 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -37,6 +37,7 @@
 
 #include <mach/board.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 9c24cb2..90af119 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -40,6 +40,7 @@
 #include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 82bdfde..8f4ba07 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -29,6 +29,7 @@
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 6cc83a8..790791a 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -35,6 +35,7 @@
 #include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 69ab124..1f7bc1f 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -44,6 +44,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index a9d5e78..8bf7046 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -35,6 +35,7 @@
 #include <mach/at91sam9_smc.h>
 #include <mach/gsia18s.h>
 #include <mach/stamp9g20.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 64c1dbf..5945808 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -37,6 +37,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/cpu.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 5d96cb8..3a88688 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -40,6 +40,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 18103c5d..5deb106 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -47,6 +47,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 9ca3e32..d622a07 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -33,6 +33,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/stamp9g20.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 1270655..a33a6b5 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -41,6 +41,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index bf351e2..655b1f3 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -44,6 +44,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index cc2bf97..0e42db0 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -43,6 +43,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 62e19e6..b1d0d36 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -43,6 +43,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
index c3b43ae..f2b4d26 100644
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -27,6 +27,7 @@
 #include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/at91_aic.h>
+#include <mach/gpio.h>
 
 #include <linux/gpio.h>
 
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 7bf6da7..0a7e7e2 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -40,6 +40,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 889c1bf..232a9f6 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -45,6 +45,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/gpio.h>
 #include <mach/system_rev.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 2269be5..13cb9b4 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -49,6 +49,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/gpio.h>
 #include <mach/system_rev.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 82adf58..d1ce5cb 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -48,6 +48,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/gpio.h>
 #include <mach/system_rev.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 4ea4ee0..4aecb95 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -46,6 +46,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 #include <mach/system_rev.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 3d48ec1..74a7101 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -46,6 +46,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/gpio.h>
 #include <mach/system_rev.h>
 
 #include "sam9_smc.h"
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index e7dc3ea..2a03138 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -34,6 +34,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index a4e031a..4eeae73 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -35,6 +35,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 29eae16..836d25c 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -28,6 +28,7 @@
 #include <mach/board.h>
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index c1476b9..76b5271 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -45,6 +45,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
+#include <mach/gpio.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 516d340..d98ae49 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -48,6 +48,7 @@
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index be42cf0..f498461 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -28,6 +28,7 @@
 
 #include <asm/mach/irq.h>
 
+#include <mach/gpio.h>
 #include <mach/hardware.h>
 #include <mach/at91_pio.h>
 
diff --git a/arch/arm/mach-at91/leds.c b/arch/arm/mach-at91/leds.c
index 8dfafe7..042ba65 100644
--- a/arch/arm/mach-at91/leds.c
+++ b/arch/arm/mach-at91/leds.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/board.h>
+#include <mach/gpio.h>
 
 
 /* ------------------------------------------------------------------------- */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 2c2d865..363c40e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -28,6 +28,7 @@
 #include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
+#include <mach/gpio.h>
 
 #include "generic.h"
 #include "pm.h"
-- 
1.7.9.5
