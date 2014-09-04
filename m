From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Thu, 4 Sep 2014 07:55:09 +0000
Subject: [PATCH V3 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <3908508.RbGYaA1nXT@wuerfel>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409757194-28155-5-git-send-email-bhupesh.sharma@freescale.com>
 <3908508.RbGYaA1nXT@wuerfel>
Message-ID: <5dcffbb315b14465ae1ba569c553b522@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, September 04, 2014 12:05 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Sharma Bhupesh-B45370; Catalin.Marinas at arm.com; mark.rutland at arm.com;
> rob.herring at linaro.org; marc.zyngier at arm.com; Will.Deacon at arm.com; Yoder
> Stuart-B08248; grant.likely at secretlab.ca; Basu Arnab-B45036
> Subject: Re: [PATCH V3 4/6] arm64: Add DTS support for FSL's LS2085A SoC
> 
> On Wednesday 03 September 2014 20:43:12 Bhupesh Sharma wrote:
> > diff --git a/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> > b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> > new file mode 100644
> > index 0000000..3c0f953
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> > @@ -0,0 +1,26 @@
> > +/*
> > + * Device Tree file for Freescale LS2085a software Simulator model
> > + *
> > + * Copyright (C) 2014, Freescale Semiconductor
> > + *
> > + * Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> >
> 
> One more thing, same comment as for the respective Exynos7 patch:
> can this please be a permissive license, like GPLv2+MIT dual license?
> 

Yes. I saw Russell's email in which he mentions that Linus is ok with using the MIT
X11 licenses ([1]). However, I am not sure I understand the GPLv2+MIT dual license.
Is it listed separately on [2], or is it a sum of the X11 + GPLv2 clauses mentioned in [2].

[1] http://www.spinics.net/lists/arm-kernel/msg358782.html
[2] http://www.gnu.org/licenses/license-list.html

Regards,
Bhupesh
