From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 25 Feb 2011 11:02:46 +0530
Subject: [PATCH 0/3] OMAP2+: voltage: first pass at cleanup/reorganization
In-Reply-To: <alpine.DEB.2.00.1102242201410.6198@utopia.booyaka.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
	<553cd99ec29ee91e4a4b324d0f4a0be7@mail.gmail.com>
	<alpine.DEB.2.00.1102242201410.6198@utopia.booyaka.com>
Message-ID: <152f5892a6651cd0268573cb9b317efa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Friday, February 25, 2011 10:33 AM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
Kevin Hilman; Nishanth Menon; Benoit Cousson;
> Mike Turquette
> Subject: RE: [PATCH 0/3] OMAP2+: voltage: first pass at
cleanup/reorganization
>
> Hi Rajendra,
>
> On Thu, 24 Feb 2011, Rajendra Nayak wrote:
>
> > I found these abort on my 4430SDP. The below changes I found
> > are needed for it to bootup..
> > I tested the 'integration-2.6.39' branch of
> > git://git.pwsan.com/linux-integration and the patch is
> > based on this branch.
>
> Thanks very much for the patch, this looks right.  Do you mind if I fold
> it into the "OMAP2+: voltage: reorganize, split code from data" patch
and
> credit you appropriately in the patch description?  (That way, there
won't
> be any gaps between patches where OMAP4 won't work.)

I agree it makes sense to fold these changes into the original patch.
Please go ahead.
Thanks,
Rajendra

>
>
> - Paul
