From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 1 Sep 2010 11:26:43 +0530
Subject: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
In-Reply-To: <1283257116.28248.20.camel@e102109-lin.cambridge.arm.com>
References: <1282926826.5075.21.camel@m0nster>
	<1282927746.26355.74.camel@e102109-lin.cambridge.arm.com>
	<1282938790.5075.25.camel@m0nster>
	<1283257116.28248.20.camel@e102109-lin.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCED0EEC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Tuesday, August 31, 2010 5:49 PM
> To: Daniel Walker
> Cc: Jeff Ohlstein; Russell King; linux-arm-msm at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Tony Lindgren;
> Kirill A. Shutemov; Shilimkar, Santosh
> Subject: Re: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
> 
> On Fri, 2010-08-27 at 20:53 +0100, Daniel Walker wrote:
> > On Fri, 2010-08-27 at 17:49 +0100, Catalin Marinas wrote:
> >
> > > > So your saying it makes more sense to change the msm entry into the
> > > > default entry, and make the current default into the
> > > > ARM11MPCore/Cortex-A9 entry?
> > >
> > > So my opinion is to not add any specific msm code but make the
> > > __v7_setup skip the ACTLR bit setting. Then add an entry for Cortex-A9
> > > to set those bits.
> > >
> >
> > how about this? Naming is of course flexible ..
> 
> I cc'ed Santosh as well. I'm not sure whether TI are using a Cortex-A9
> but with different manufacturer field (I suspect it's still 0x41).
> 
Yep. OMAP4 CA-9 field is 0x41.

Regards,
Santosh
