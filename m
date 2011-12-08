From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 8 Dec 2011 13:45:47 +0000
Subject: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <20111207211029.GL31337@atomide.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-1-git-send-email-hvaibhav@ti.com> <87y5up44bf.fsf@ti.com>
 <20111207211029.GL31337@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8050F6D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Thursday, December 08, 2011 2:40 AM
> To: Hilman, Kevin
> Cc: Hiremath, Vaibhav; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; paul at pwsan.com
> Subject: Re: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
> 
> * Kevin Hilman <khilman@ti.com> [111206 15:52]:
> > <hvaibhav@ti.com> writes:
> >
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > This patch set adds support for AM335x device having
> > > Cortex-A8 MPU.
> > >
> > > Official website - http://www.ti.com/product/am3359
> > >
> > > AM335X is treated as another OMAP3 variant, where,
> > > along with existing cpu class OMAP34XX, new cpu class AM33XX is
> created
> > > and the respective type is AM335X, which is newly added device in
> > > the family.
> > > This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> > > cpu_is_am335x() checks return success for AM335X.
> > >
> > > Also, I have validated OMAP3 boot test with this patch-series on
> > > OMAP3EVM.
> >
> > Tony, this series looks good to me.
> >
> > I've also tested it on a BeagleBone, so feel free to also add:
> >
> > Tested-by: Kevin Hilman <khilman@ti.com>
> 
> Thanks looks good to me. We still need the machine_id update to
> apply patches 2 and 3 in this series, so applying only the first
> patch into soc branch for now.
> 

Tony,

Should I ping Russell for this? The machine-id patch is already registered
and present at

http://www.arm.linux.org.uk/developer/machines/download.php

Thanks,
Vaibhav

> Tony
