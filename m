From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 14 Oct 2010 19:25:05 +0200
Subject: [PATCH 4/5] AT91: rename at91sam9g20_reset.S to generalize to several
	chips
In-Reply-To: <20100528153725.GA5102@axolotl.localnet>
References: <20100528153725.GA5102@axolotl.localnet>
Message-ID: <e4f3c8e534b3cfb5ae5cfd3e87cb16c95e4238c4.1287076894.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Makefile                        |    2 +-
 .../{at91sam9g20_reset.S => at91sam9_alt_reset.S}  |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-at91/{at91sam9g20_reset.S => at91sam9_alt_reset.S} (100%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index d4bb704..15fee8b 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam926x_time.o at91sam9261_d
 obj-$(CONFIG_ARCH_AT91SAM9G10)	+= at91sam9261.o at91sam926x_time.o at91sam9261_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9263)	+= at91sam9263.o at91sam926x_time.o at91sam9263_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devices.o sam9_smc.o
-obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9g20_reset.o
+obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
 obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT572D940HF)  += at572d940hf.o at91sam926x_time.o at572d940hf_devices.o sam9_smc.o
diff --git a/arch/arm/mach-at91/at91sam9g20_reset.S b/arch/arm/mach-at91/at91sam9_alt_reset.S
similarity index 100%
rename from arch/arm/mach-at91/at91sam9g20_reset.S
rename to arch/arm/mach-at91/at91sam9_alt_reset.S
-- 
1.7.3
