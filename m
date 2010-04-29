From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Apr 2010 09:26:20 +0100
Subject: [PATCH] arch/arm: Fix missing define for ARM_PMU_DEVICE_CPU
In-Reply-To: <20100429081218.GA14783@wear.picochip.com>
References: <201004290231.03440.PeterHuewe@gmx.de>
	<20100429081218.GA14783@wear.picochip.com>
Message-ID: <1272529580.24662.10.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

Thanks for CC'ing me on this.

On Thu, 2010-04-29 at 09:12 +0100, Jamie Iles wrote:
> On Thu, Apr 29, 2010 at 02:31:03AM +0200, Peter Huewe wrote:
> > From: Peter Huewe <peterhuewe@gmx.de>
> >
> > This patch adds a define for ARM_PMU_DEVICE_CPU which seemed to be
> > missing/undefined and caused some build failures [1-4].
> >
> > I defined ARM_PMU_DEVICE_CPU = -1 as stated in
> > Documentation/driver_model/platform.txt to indicate there is only
> one.
> > I'm _not_ sure if this is correct, but due to the static nature of
> the
> > define I assume it is.
> Hi Peter,
> 
> This build error is due to the core patch of Will's "ARM: pmu: provide
> a
> registration mechanism for IRQs" patch series not being merged yet.
> I'm not
> sure what the status of that patch is at the moment though.

I submitted the series to Russell's patch system on 9 April.
However, as you know, he's currently without an internet connection and
the patch system has gone offline. He applied some of the series before
he lost connectivity, so I expect he'll look at the others when he's
back [although I imagine there are lots of other patches in the same
situation].

Peter: if you're interested, the patch series I sent to the ARM
Linux list is archived here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012113.html

Cheers,

Will
