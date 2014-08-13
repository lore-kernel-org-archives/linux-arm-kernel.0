From: zonque@gmail.com (Daniel Mack)
Date: Wed, 13 Aug 2014 21:59:18 +0200
Subject: [PATCH 1/2] ARM: pxa: ssp: provide platform_device_id for PXA3xx
Message-ID: <1407959959-4977-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide an explicit match string for PXA3xx SSP ports.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 3ea0290..1f5ee17 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -258,6 +258,7 @@ static const struct platform_device_id ssp_id_table[] = {
 	{ "pxa25x-ssp",		PXA25x_SSP },
 	{ "pxa25x-nssp",	PXA25x_NSSP },
 	{ "pxa27x-ssp",		PXA27x_SSP },
+	{ "pxa3xx-ssp",		PXA3xx_SSP },
 	{ "pxa168-ssp",		PXA168_SSP },
 	{ "pxa910-ssp",		PXA910_SSP },
 	{ },
-- 
2.0.4
