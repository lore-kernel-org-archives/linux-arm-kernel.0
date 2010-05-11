From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 11 May 2010 04:26:57 +0200
Subject: [PATCH 3/4] pxa/colibri270: Add FFUART MFP
In-Reply-To: <1273544818-22305-1-git-send-email-marek.vasut@gmail.com>
References: <1273544818-22305-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1273544818-22305-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa270.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 5490c5f..18b208a 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -54,6 +54,10 @@ static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
 	GPIO111_MMC_DAT_3,
 	GPIO112_MMC_CMD,
 	GPIO0_GPIO,	/* SD detect */
+
+	/* FFUART */
+	GPIO39_FFUART_TXD,
+	GPIO34_FFUART_RXD,
 };
 
 /******************************************************************************
-- 
1.7.0
