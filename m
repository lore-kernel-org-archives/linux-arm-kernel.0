From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Feb 2010 08:14:18 -0800
Subject: [PATCH 0/5] cache-l2x0 and omap4 l2 support
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B42645@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B425F9@dbde02.ent.ti.com>
	<20100204144344.GC27344@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C0B42645@dbde02.ent.ti.com>
Message-ID: <20100204161417.GQ22747@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100204 07:59]:
> Tony,
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: Thursday, February 04, 2010 8:14 PM
> > To: Shilimkar, Santosh
> > Cc: Tony Lindgren; Catalin Marinas; linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> > Subject: Re: [PATCH 0/5] cache-l2x0 and omap4 l2 support
> > 
> > On Thu, Feb 04, 2010 at 07:52:52PM +0530, Shilimkar, Santosh wrote:
> > > Russell / Tony,
> > >
> > > Here is the series which combines earlier two series because of dependency and
> > > rebased against 2.6.33-rc2. This series also implements Russell's suggested
> > > combined monitor API. Tested on OMAP4430 SDP
> > 
> > If you fix up those two patches, I think it can to into the patch system
> > when some acks have been received.
> 
> Can you check this series and provide your ack. Will you be ok if this series
> gets merged through Russell's patch system ?

Yeah looks good to me for all of them:

Acked-by: Tony Lindgren <tony@atomide.com>
