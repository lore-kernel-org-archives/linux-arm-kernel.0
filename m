From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 15 Dec 2010 16:44:58 +0530
Subject: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
	2.6.38,part two
In-Reply-To: <alpine.DEB.2.00.1012142057030.15971@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<a52218d5bcff8d959b86230ce9a7ca89@mail.gmail.com>
	<alpine.DEB.2.00.1012142057030.15971@utopia.booyaka.com>
Message-ID: <b49f721f09976988f78ce7faf0499654@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Wednesday, December 15, 2010 9:28 AM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
Mark Brown; Benoit Cousson; Kevin Hilman;
> Peter Ujfalusi; Santosh Shilimkar; Jarkko Nikula; Liam Girdwood
> Subject: RE: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches
for 2.6.38,part two
>
> On Tue, 14 Dec 2010, Rajendra Nayak wrote:
>
> > Boot tested on 2430/3430/4430SDP. Tested RET/OFF mode in suspend
> > on 3430SDP with minimal config (omap3_pm_defconfig).
>
> Thanks for testing this.  Would you like me to add Tested-by:'s ?

Sure,
Tested-by: Rajendra Nayak <rnayak@ti.com>

>
> Also, I still plan to make that change that you proposed to cause the
> prminst, cminst functions to read/write directly to the registers...
> soon...

Thanks, already had a look.

>
>
> - Paul
