From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 25 Jul 2014 00:14:56 -0700
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <20140725061320.GG8181@intel.com>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140724121315.GV20328@lukather>
 <20140724164420.d7c58c9b5f6bf3e06137494f@linux-foundation.org>
 <20140725061130.GF8181@intel.com> <20140725061320.GG8181@intel.com>
Message-ID: <20140725001456.e1e3e9a1.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jul 2014 11:43:20 +0530 Vinod Koul <vinod.koul@intel.com> wrote:

> On Fri, Jul 25, 2014 at 11:41:30AM +0530, Vinod Koul wrote:
> > On Thu, Jul 24, 2014 at 04:44:20PM -0700, Andrew Morton wrote:
> > > On Thu, 24 Jul 2014 14:13:15 +0200 Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > > 
> > > > On Thu, Jul 17, 2014 at 09:46:14PM +0200, Maxime Ripard wrote:
> > > > > Hi,
> > > > > 
> > > > > This patchset adds support for the DMA controller found in the
> > > > > Allwinner A31 and A23 SoCs.
> > > > > 
> > > > > This has been tested using the newly introduced SPI driver on an A31
> > > > > EVK. Support for DMA-driven SPI transfers will be the subject of
> > > > > another patch serie.
> > > > > 
> > > > > This has been around for around 5 monthes now, and didn't get any
> > > > > review but nitpicks for three versions, so I feel like it could be
> > > > > merged quite quickly.
> > > > 
> > > > Ok, so, who should I bribe to get this merged?
> > > 
> > > Turns out I'm easily bribed.  The code looks pretty clean and simple
> > > and is refreshingly free of comments, which only confuse people anyway.
> > Sorry for the delay, I will get this done today and merge to slave-dmaengine
> > next
> And looks like Andrew merged them. Do you mind if I take these up thru
> dmaengine tree?

Sure.  If a patch turns up in linux-next I'll autodrop my copy.
