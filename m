From: mporter@ti.com (Matt Porter)
Date: Thu, 24 Jan 2013 15:42:03 -0500
Subject: [PATCH v5 00/14] DMA Engine support for AM33XX
In-Reply-To: <d07dbfd50690423b903803720152c0dc@DLEE74.ent.ti.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <50FEB6B2.5020303@ti.com>
 <20130123022133.GA5727@opensource.wolfsonmicro.com>
 <20130123213736.GC5256@beef>
 <d07dbfd50690423b903803720152c0dc@DLEE74.ent.ti.com>
Message-ID: <20130124204203.GD5256@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 05:14:13AM +0000, Sekhar Nori wrote:
> Matt,
> 
> On 1/24/2013 3:07 AM, Matt Porter wrote:
> > On Wed, Jan 23, 2013 at 10:21:42AM +0800, Mark Brown wrote:
> >> On Tue, Jan 22, 2013 at 09:26:34PM +0530, Sekhar Nori wrote:
> >>> On 1/16/2013 2:02 AM, Matt Porter wrote:
> >>
> >>>> This series adds DMA Engine support for AM33xx, which uses
> >>>> an EDMA DMAC. The EDMA DMAC has been previously supported by only
> >>>> a private API implementation (much like the situation with OMAP
> >>>> DMA) found on the DaVinci family of SoCs.
> >>
> >>> Will you take this series through the OMAP tree? Only 1/14 touches
> >>> mach-davinci and I am mostly okay with it except some changes I just
> >>> requested Matt to make in another thread.
> >>
> >> Is this series somewhere near actually getting merged then? It seemed
> >> like there was lots of stuff going on.
> > 
> > The issues raised by Sekhar and Santosh were reasonably minor and will
> > be addressed. My major concern is that the dependency on some api to
> > fetch dmaengine driver SG limitations is not resolved. That's being
> > discussed in https://lkml.org/lkml/2013/1/10/432
> 
> It might be worth posting the patches which don't have dependencies and
> are ready for acceptance as a separate series. That way at least some of
> these patches have a good chance of getting into v3.9 if not the entire
> series.

Yes a good idea and seems to be the best option. I've dropped the mmc
support from the series for the next version. I'll repost the separately
when we have an api to support it.

-Matt
