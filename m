From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:16:17 +0200
Subject: [PATCH 2/10] IXP4xx: Fix off-by-one bug in Goramo MultiLink platform.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3mx0k30xa.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -330,7 +330,7 @@ static struct platform_device device_hss_tab[] = {
 };
 
 
-static struct platform_device *device_tab[6] __initdata = {
+static struct platform_device *device_tab[7] __initdata = {
 	&device_flash,		/* index 0 */
 };
 

-- 
Krzysztof Halasa
