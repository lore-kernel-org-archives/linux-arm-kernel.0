From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Feb 2011 08:46:36 +0900
Subject: [PATCH 5/6] ARM: pm: convert samsung platforms to generic
	suspend/resume support
In-Reply-To: <20110217232947.GA4110@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvhv-0002yp-A0@rmk-PC.arm.linux.org.uk>
	<017901cbce9b$7b405ee0$71c11ca0$%kim@samsung.com>
	<20110217140621.GC24989@n2100.arm.linux.org.uk>
	<01b001cbcef7$3e7f5f90$bb7e1eb0$%kim@samsung.com>
	<20110217232947.GA4110@n2100.arm.linux.org.uk>
Message-ID: <01b401cbcefc$ed4f51b0$c7edf510$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Fri, Feb 18, 2011 at 08:05:57AM +0900, Kukjin Kim wrote:
> > Russell King - ARM Linux wrote:
> > >
> > > On Thu, Feb 17, 2011 at 09:09:02PM +0900, Kukjin Kim wrote:
> > > > Hi Russell,
> > > >
> > > > I tested on SMDKV210(S5PV210) and SMDKC110(S5PC110).
> > >
> > > Thanks for testing.  It looks like I'm missing a load for r3 in the
> > > s5pv210 code.  The replacement patch below should resolve this.
> > >
> >
> > Hooray, it works fine ;)
> >
> > Tested-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Thanks.  I'm assuming that applies to:
> 
> "ARM: pm: add generic CPU suspend/resume support"
> 
> too as you can't test this without that patch.

Yeah, it's ok to me :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
