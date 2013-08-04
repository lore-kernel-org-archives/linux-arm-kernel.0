From: zonque@gmail.com (Daniel Mack)
Date: Sun,  4 Aug 2013 16:13:21 +0200
Subject: [PATCH 2/2] ARM: pxa: fix pwri2c of_dev_auxdata entry
In-Reply-To: <1375625601-32257-1-git-send-email-zonque@gmail.com>
References: <1375625601-32257-1-git-send-email-zonque@gmail.com>
Message-ID: <1375625601-32257-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/pxa-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index 3e1ec71..b6acb5f 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -31,7 +31,7 @@ static const struct of_dev_auxdata pxa3xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("intel,pxa3xx-gpio",	0x40e00000, "pxa3xx-gpio", NULL),
 	OF_DEV_AUXDATA("marvell,pxa-ohci",	0x4c000000, "pxa27x-ohci", NULL),
 	OF_DEV_AUXDATA("mrvl,pxa-i2c",		0x40301680, "pxa2xx-i2c.0", NULL),
-	OF_DEV_AUXDATA("mrvl,pwri2c",		0x40f500c0, "pxa3xx-i2c.1", NULL),
+	OF_DEV_AUXDATA("mrvl,pwri2c",		0x40f500c0, "pxa3xx-pwri2c.1", NULL),
 	OF_DEV_AUXDATA("marvell,pxa3xx-nand",	0x43100000, "pxa3xx-nand", NULL),
 	OF_DEV_AUXDATA("mrvl,pxa27x-ssp",	0x41000000, "pxa27x-ssp.0", NULL),
 	OF_DEV_AUXDATA("mrvl,pxa27x-ssp",	0x41700000, "pxa27x-ssp.1", NULL),
-- 
1.8.3.1
