From: kys@microsoft.com (KY Srinivasan)
Date: Tue, 27 Nov 2018 03:06:55 +0000
Subject: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
In-Reply-To: <20181126191812.GA32208@kroah.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181126191812.GA32208@kroah.com>
Message-ID: <CY4PR2101MB080498D01F0DC5A90C1E4F8FA0D00@CY4PR2101MB0804.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, November 26, 2018 11:18 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: will.deacon at arm.com; catalin.marinas at armm.com;
> mark.rutland at arm.com; marc.zyngier at arm.com; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devel at linuxdriverproject.org; olaf at aepfle.de; apw at canonical.com;
> jasowang at redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> Michael Kelley <mikelley@microsoft.com>; vkuznets
> <vkuznets@redhat.com>; Michael Kelley <mikelley@microsoft.com>
> Subject: Re: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
> 
> On Thu, Nov 22, 2018 at 03:10:56AM +0000, kys at linuxonhyperv.com wrote:
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> > @@ -0,0 +1,338 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This file contains definitions from the Hyper-V Hypervisor Top-Level
> > + * Functional Specification (TLFS):
> > + *
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.
> microsoft.com%2Fen-us%2Fvirtualization%2Fhyper-v-on-
> windows%2Freference%2Ftlfs&amp;data=02%7C01%7Ckys%40microsoft.co
> m%7Cce3a8662cbbc4afe157508d653d3eadf%7C72f988bf86f141af91ab2d7cd0
> 11db47%7C1%7C0%7C636788566988323167&amp;sdata=VJHHMNbpOdAANd
> DNUD3UMuR8SkbBGOew7uy%2B%2BUCS2sE%3D&amp;reserved=0
> 
> "interesting" url :(
> 
> Care to use a real one?

Will fix and resend.

K. Y
> 
> thanks,
> 
> greg k-h
