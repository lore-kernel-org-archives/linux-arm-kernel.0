From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:46:00 +0200
Subject: [PATCH 05/13] mach-cpuimx27: fix QuadUART's IRQ typo in pins'setup
In-Reply-To: <1274287568-30253-4-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-5-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/mach-cpuimx27.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index 5c6a16b..a3449ed 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -88,10 +88,10 @@ static int eukrea_cpuimx27_pins[] = {
 #endif
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 	/* Quad UART's IRQ */
-	GPIO_PORTD | 22 | GPIO_GPIO | GPIO_IN,
-	GPIO_PORTD | 23 | GPIO_GPIO | GPIO_IN,
-	GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN,
-	GPIO_PORTD | 30 | GPIO_GPIO | GPIO_IN,
+	GPIO_PORTB | 22 | GPIO_GPIO | GPIO_IN,
+	GPIO_PORTB | 23 | GPIO_GPIO | GPIO_IN,
+	GPIO_PORTB | 27 | GPIO_GPIO | GPIO_IN,
+	GPIO_PORTB | 30 | GPIO_GPIO | GPIO_IN,
 #endif
 };
 
-- 
1.6.3.3
