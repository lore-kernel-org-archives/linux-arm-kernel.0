From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Mar 2015 10:06:25 +0200
Subject: [RESEND 1/7] ARM: davinci: devices-da8xx: Add resource name for the
 McASP DMA request
In-Reply-To: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1426147591-31764-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "tx" or "rx" as resource name for the DMA resources.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index b85b781b05fd..f35174317770 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -463,12 +463,14 @@ static struct resource da830_mcasp1_resources[] = {
 	},
 	/* TX event */
 	{
+		.name	= "tx",
 		.start	= DAVINCI_DA830_DMA_MCASP1_AXEVT,
 		.end	= DAVINCI_DA830_DMA_MCASP1_AXEVT,
 		.flags	= IORESOURCE_DMA,
 	},
 	/* RX event */
 	{
+		.name	= "rx",
 		.start	= DAVINCI_DA830_DMA_MCASP1_AREVT,
 		.end	= DAVINCI_DA830_DMA_MCASP1_AREVT,
 		.flags	= IORESOURCE_DMA,
@@ -491,12 +493,14 @@ static struct resource da850_mcasp_resources[] = {
 	},
 	/* TX event */
 	{
+		.name	= "tx",
 		.start	= DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
 		.end	= DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
 		.flags	= IORESOURCE_DMA,
 	},
 	/* RX event */
 	{
+		.name	= "rx",
 		.start	= DAVINCI_DA8XX_DMA_MCASP0_AREVT,
 		.end	= DAVINCI_DA8XX_DMA_MCASP0_AREVT,
 		.flags	= IORESOURCE_DMA,
-- 
2.3.0
