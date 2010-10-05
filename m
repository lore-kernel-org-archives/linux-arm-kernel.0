From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 5 Oct 2010 10:49:13 +0530
Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
In-Reply-To: <alpine.DEB.2.00.1010042253210.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101001213532.1408.55832.stgit@twilight.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
	<20101004065624.GD2559@legolas.emea.dhcp.ti.com>
	<20101004070040.GE2559@legolas.emea.dhcp.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1010041327040.13816@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA07@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1010042253210.13816@utopia.booyaka.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA62@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, October 05, 2010 10:26 AM
> To: Shilimkar, Santosh
> Cc: Balbi, Felipe; khilman at deeprootsystems.com; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
> 
> On Tue, 5 Oct 2010, Shilimkar, Santosh wrote:
> 
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul at pwsan.com]
> > > Sent: Tuesday, October 05, 2010 1:02 AM
> > >
> > > It's great that this is getting cleaned up but it's too late for
> 2.6.37.
> > > We stop taking new code after -rc6 comes out so we can try to get all
> of
> > > the changes integrated with each other and fix any bugs.
> > >
> > The patch was lying on the list for quite some time but didn't get much
> > attention before.
> 
> According to my archives, it looks like Kevin did quite a bit of review on
> it and requested that it be converted to use omap_hwmod, after which there
> was no response.  If it was converted to use hwmod and pm_runtime, it
> probably could have gone in with the other hwmod conversions in the .37
> merge window.
> 
Thanks Paul. As aligned, the hwmod + runtime is way to go for this one then.

-Santosh
