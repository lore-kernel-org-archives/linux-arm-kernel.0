From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 20 Jan 2010 22:06:14 -0700 (MST)
Subject: [PATCH] OMAP CPU ID: fix OMAP4 build failure
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CCEB1@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1001202008530.3977@utopia.booyaka.com>
	<alpine.DEB.2.00.1001202025410.3977@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C07CCEB1@dbde02.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1001202205510.24456@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jan 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Paul
> > Walmsley
> > 
> > I guess the rollup should probably be CHIP_IS_OMAP44XX.  Do you happen to
> > know whether software will be able to discriminate between 4430 and 4440
> > chips at run-time, and if so, what mechanism to use?
> ID_CODE would be different which can be used for this.

Okay, great.

- Paul
