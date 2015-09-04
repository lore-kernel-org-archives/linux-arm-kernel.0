From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Fri, 4 Sep 2015 20:10:30 +0000
Subject: [PATCH v2 01/10] arm64: Use generic Layerscape SoC family naming
 & rename LS2085A to LS2080A
In-Reply-To: <CADRPPNQbTPrJ47SKsA=EaPi7xo8+0hQqEpt3wDPKMbL1vTOr9A@mail.gmail.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-2-git-send-email-bhupesh.sharma@freescale.com>
 <CADRPPNQbTPrJ47SKsA=EaPi7xo8+0hQqEpt3wDPKMbL1vTOr9A@mail.gmail.com>
Message-ID: <BY1PR0301MB13036EDCAC8E826853A71CB282570@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com]
> Sent: Friday, September 04, 2015 10:01 PM
> On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
> <bhupesh.sharma@freescale.com> wrote:
> > Freescale will be a churning out a host of ARMv8 based SoCs which will
> > be based on a similar overall SoC architecture. So, this patch
> > converts the existing infrastructure in the arm64/dts, arm64/Kconfig
> > and arm64/configs to use the generic convention ARCH_LAYERSCAPE in
> > place of the more specific FSL_LS2085A, to save code duplication
> > later-on.
> >
> > Also Freescale is renaming LS2085A to LS2080A.
> >
> > This patch addresses the above two points.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > ---
> {snip}
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > @@ -1,7 +1,7 @@
> >  /*
> > - * Device Tree Include file for Freescale Layerscape-2085A family SoC.
> > + * Device Tree Include file for Freescale Layerscape-2080A family SoC.
> >   *
> > - * Copyright (C) 2014, Freescale Semiconductor
> > + * Copyright (C) 2014-15, Freescale Semiconductor
> 
> Normally we spell out the whole 2015.  The preferred copyright template
> is:
> 
> Copyright 2014-2015 Freescale Semiconductor, Inc.
> 

Ok.

Regards,
Bhupesh
