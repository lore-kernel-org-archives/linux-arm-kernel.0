From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Thu, 15 Oct 2015 19:58:09 +0000
Subject: [PATCH v3 12/12] dts/Makefile: Add build support for LS2080a QDS
 & RDB board DTS
In-Reply-To: <6113441.JKoMX6G60g@wuerfel>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
 <1444891672-32117-13-git-send-email-bhupesh.sharma@freescale.com>
 <6113441.JKoMX6G60g@wuerfel>
Message-ID: <BY1PR0301MB1303114E40DED290D699792A823E0@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, October 15, 2015 7:50 PM
> 
> On Thursday 15 October 2015 12:17:52 Bhupesh Sharma wrote:
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> > index 932001a..57b41c7 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -1,4 +1,4 @@
> > -dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb fsl-ls2080a-
> rdb.dtb fsl-ls2080a-simu.dtb
> >
> >
> 
> Please use one line per dtb file here, for consistency with the other
> platforms
> 

Ok, will address in v4.

Regards,
Bhupesh
