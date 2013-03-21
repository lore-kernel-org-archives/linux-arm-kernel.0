From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Mar 2013 22:57:30 +0800
Subject: [PATCH 1/2] dmaengine: add const for name parameter
In-Reply-To: <20130321094753.GN10326@intel.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
 <20130315085346.GA22650@pengutronix.de>
 <20130321094753.GN10326@intel.com>
Message-ID: <20130321145728.GD23109@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

On Thu, Mar 21, 2013 at 03:17:53PM +0530, Vinod Koul wrote:
> On Fri, Mar 15, 2013 at 09:53:46AM +0100, Markus Pargmann wrote:
> > Hi,
> > 
> > I already sent a nearly identical patch:
> > https://patchwork.kernel.org/patch/2179321/
> I applied that one a while ago so Markus can you check my tree and see if
> anything is remaining, looks most of cases are covered
> 
Can you maintain that patch on a topic branch, so that we can ask Mark
to pull it as dependency for the soc-dmaengine-pcm patch that support
generic DMA binding users?

Shawn
