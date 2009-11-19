From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:18 +0100
Subject: [PATCH 04/12] i.MX31 clock: rename SSI clocks to driver name
In-Reply-To: <1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/clock.c b/arch/arm/mach-mx3/clock.c
index b2a3bcf..3089786 100644
--- a/arch/arm/mach-mx3/clock.c
+++ b/arch/arm/mach-mx3/clock.c
@@ -558,8 +558,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
 	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
 	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
-	_REGISTER_CLOCK(NULL, "ssi", ssi1_clk)
-	_REGISTER_CLOCK(NULL, "ssi", ssi2_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK(NULL, "firi", firi_clk)
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
-- 
1.6.5.2
