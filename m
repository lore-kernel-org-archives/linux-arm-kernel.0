From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Thu, 25 Mar 2010 18:22:32 +0100
Subject: [PATCH 01/16] ARM mach-at91: duplicated include
In-Reply-To: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
References: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1269537767-7553-2-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-at91/board-sam9m10g45ek.c: mach/hardware.h is included more than once

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-at91/board-sam9m10g45ek.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 98f9f4b..ee80059 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -25,7 +25,6 @@
 #include <linux/leds.h>
 #include <linux/clk.h>
 
-#include <mach/hardware.h>
 #include <video/atmel_lcdc.h>
 
 #include <asm/setup.h>
-- 
1.7.0.3.296.g9776a
