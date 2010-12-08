From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 8 Dec 2010 11:29:37 +0530
Subject: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
	forCONFIG_THUMB2_KERNEL
In-Reply-To: <2080abb418a8d3c651dd41353ef59d25@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org><1291656937-24992-3-git-send-email-dave.martin@linaro.org><a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
	<AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
	<2080abb418a8d3c651dd41353ef59d25@mail.gmail.com>
Message-ID: <d9fec68fc0ce14215439c6e753871bc2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Wednesday, December 08, 2010 11:27 AM
> To: Dave Martin
> Cc: linux-arm-kernel at lists.infradead.org; Tony Lindgren; linux-
> omap at vger.kernel.org; linaro-dev at lists.linaro.org
> Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
> forCONFIG_THUMB2_KERNEL
>
> > -----Original Message-----
> > From: Dave Martin [mailto:dave.martin at linaro.org]
> > Sent: Tuesday, December 07, 2010 10:21 PM
> > To: Santosh Shilimkar
> > Cc: linux-arm-kernel at lists.infradead.org; Tony Lindgren; linux-
> > omap at vger.kernel.org; linaro-dev at lists.linaro.org
> > Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
> > forCONFIG_THUMB2_KERNEL
> >
> > Hi,
> >
> > On Tue, Dec 7, 2010 at 6:28 AM, Santosh Shilimkar
> > <santosh.shilimkar@ti.com> wrote:
> > > Dave,

[.....]
>
> > So anything inside #ifdef CONFIG_THUMB2_KERNEL can assume v7/Thumb-2
> > capable (and hence reasonably new) tools.
> >
> > I'll follow up shortly with a patch to the generic ARM Kconfig to make
> > this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't accidentally
> > be configured together.
> >
> sure

When you are doing the changes can you please check if you could build
the THUMB2 kernel with omap2plus_defconfig. I suspect the build will
fail.

Regards,
Santosh
