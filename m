From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 May 2013 13:53:41 +0800
Subject: [PATCH v2 0/2] dma: imx-sdma: add generic DMA device tree
 bindings support
In-Reply-To: <20130524050329.GN30200@intel.com>
References: <1366901008-7593-1-git-send-email-shawn.guo@linaro.org>
 <20130524052903.GE2704@S2101-09.ap.freescale.net>
 <20130524050329.GN30200@intel.com>
Message-ID: <20130524055338.GG2704@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 10:33:29AM +0530, Vinod Koul wrote:
> On Fri, May 24, 2013 at 01:29:05PM +0800, Shawn Guo wrote:
> > Vinod,
> > 
> > On Thu, Apr 25, 2013 at 10:43:26PM +0800, Shawn Guo wrote:
> > > Changes since v1:
> > >  * Fix the example typo in bindings doc.  Thanks to Fabio.
> > > 
> > > Shawn Guo (2):
> > >   dma: imx: change enum definitions to macros
> > >   dma: imx-sdma: move to generic device tree bindings
> > 
> > Can you please apply these for 3.11?
> Sorry I was thinking that you will update the patchset based on Arnd last
> comment on (ab)use of macro. Can you fix that & resend

I had a response [1] on that to explain why I think the macro is
being reasonably used there.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/233361/focus=233395
