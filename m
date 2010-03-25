From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Thu, 25 Mar 2010 18:22:34 +0100
Subject: [PATCH 03/16] ARM mach-mx3: duplicated include
In-Reply-To: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
References: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1269537767-7553-4-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mx3/mx31lite-db.c: linux/platform_device.h is included more than once.

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-mx3/mx31lite-db.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index ccd8742..16c955e 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -28,7 +28,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 
-- 
1.7.0.3.296.g9776a
