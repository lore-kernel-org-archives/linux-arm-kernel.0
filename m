From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  3 Jun 2013 14:42:37 +0100
Subject: [PATCH 13/21] ARM: ux500: Remove AUXDATA relating to UART clock-name
 bindings
In-Reply-To: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370266965-7901-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 53187fc..8cdbd20 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -221,9 +221,6 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires DMA bindings. */
 	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
 	/* Requires clock name bindings. */
-	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", NULL),
-	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", NULL),
-	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", NULL),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  NULL),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  NULL),
 	OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  NULL),
-- 
1.7.10.4
