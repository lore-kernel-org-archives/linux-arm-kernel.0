From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 24 May 2013 11:02:23 +0530
Subject: [PATCH v2 0/2] dma: imx-sdma: add generic DMA device tree
 bindings support
In-Reply-To: <20130524055338.GG2704@S2101-09.ap.freescale.net>
References: <1366901008-7593-1-git-send-email-shawn.guo@linaro.org>
 <20130524052903.GE2704@S2101-09.ap.freescale.net>
 <20130524050329.GN30200@intel.com>
 <20130524055338.GG2704@S2101-09.ap.freescale.net>
Message-ID: <20130524053223.GQ30200@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 01:53:41PM +0800, Shawn Guo wrote:
> On Fri, May 24, 2013 at 10:33:29AM +0530, Vinod Koul wrote:
> > On Fri, May 24, 2013 at 01:29:05PM +0800, Shawn Guo wrote:
> > > Vinod,
> > > 
> > > On Thu, Apr 25, 2013 at 10:43:26PM +0800, Shawn Guo wrote:
> > > > Changes since v1:
> > > >  * Fix the example typo in bindings doc.  Thanks to Fabio.
> > > > 
> > > > Shawn Guo (2):
> > > >   dma: imx: change enum definitions to macros
> > > >   dma: imx-sdma: move to generic device tree bindings
> > > 
> > > Can you please apply these for 3.11?
> > Sorry I was thinking that you will update the patchset based on Arnd last
> > comment on (ab)use of macro. Can you fix that & resend
> 
> I had a response [1] on that to explain why I think the macro is
> being reasonably used there.
I see the reason for this. Arnd replied to me only. I think an honest mistake.
Here are his comments


> > Looks fine to me, Arnd?
> 
> I still think that the move of the numbers to include/dt-bindings/dma/imx.h
> is abuse of the preprocessor infrastructure and should not be there.
> The actual binding looks fine though.
> 
> 	Arnd
> 
What I didnt realize that it was not on list and you havent seen it.

Can you fix this up and resend...


--
~Vinod
> 
