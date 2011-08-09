From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 09 Aug 2011 09:04:40 +0100
Subject: [PATCH 01/13] ARM: gpio: at91: remove redundant include of mach/gpio.h
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Message-ID: <E1QqhIm-0003a0-9U@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/gpio.h already directly includes mach/gpio.h.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-at91/gpio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 4615528..2225042 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -22,7 +22,6 @@
 
 #include <mach/hardware.h>
 #include <mach/at91_pio.h>
-#include <mach/gpio.h>
 
 #include <asm/gpio.h>
 
-- 
1.7.4.4
