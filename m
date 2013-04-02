From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 2 Apr 2013 23:21:28 +0530
Subject: [PATCH 1/2] dmaengine: add const for name parameter
In-Reply-To: <20130321145728.GD23109@S2101-09.ap.freescale.net>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
 <20130315085346.GA22650@pengutronix.de>
 <20130321094753.GN10326@intel.com>
 <20130321145728.GD23109@S2101-09.ap.freescale.net>
Message-ID: <20130402175128.GN10326@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:57:30PM +0800, Shawn Guo wrote:
> Vinod,
> 
> On Thu, Mar 21, 2013 at 03:17:53PM +0530, Vinod Koul wrote:
> > On Fri, Mar 15, 2013 at 09:53:46AM +0100, Markus Pargmann wrote:
> > > Hi,
> > > 
> > > I already sent a nearly identical patch:
> > > https://patchwork.kernel.org/patch/2179321/
> > I applied that one a while ago so Markus can you check my tree and see if
> > anything is remaining, looks most of cases are covered
> > 
> Can you maintain that patch on a topic branch, so that we can ask Mark
> to pull it as dependency for the soc-dmaengine-pcm patch that support
> generic DMA binding users?
Looks like i never replied to this one, althoug I have pushed a branch

Mark,

You can pull commit a0c43a3 from topic/of or the entire branch into your tree

--
Thanks
~Vinod
