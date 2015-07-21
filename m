From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Jul 2015 15:56:43 +0100
Subject: [PATCH 1/2] arm64: dts: Add dts files for Marvell Berlin4CT SoC
In-Reply-To: <20150721225006.04c3d071@xhacker>
References: <1437488279-2088-1-git-send-email-jszhang@marvell.com>
 <1437488279-2088-2-git-send-email-jszhang@marvell.com>
 <20150721143426.GC10595@leverpostej>
 <20150721225006.04c3d071@xhacker>
Message-ID: <20150721145643.GD10595@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 03:50:06PM +0100, Jisheng Zhang wrote:
> Dear Mark,
> 
> Thanks a lot for so quick review!
> 
> On Tue, 21 Jul 2015 15:34:26 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi,
> > 
> > > +/dts-v1/;
> > > +
> > > +/memreserve/ 0x00000000 0x01000000;
> > 
> > What's this reservation for?
> 
> This is reserved for some firmwares' usage.
> 
> > 
> > Given you're using PSCI I can't see why we'd expect the kernel to map
> > but not use some memory.
> 
> Is it acceptable that we make memory start at 0x01000000 instead of reservation?

Yes, though it would still be worth a comment as to why that memory
can't be used.

Thanks,
Mark.
