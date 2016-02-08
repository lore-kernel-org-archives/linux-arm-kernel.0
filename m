From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Feb 2016 08:44:03 +0530
Subject: [PATCH 1/6] dma: enable mxs-dma for imx6ul
In-Reply-To: <20160202062314.GD8307@tiger>
References: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
 <1453294626-17608-2-git-send-email-LW@KARO-electronics.de>
 <20160125121043.GJ11130@localhost> <20160202062314.GD8307@tiger>
Message-ID: <20160208031403.GK2531@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 02:23:16PM +0800, Shawn Guo wrote:
> On Mon, Jan 25, 2016 at 05:40:43PM +0530, Vinod Koul wrote:
> > On Wed, Jan 20, 2016 at 01:57:01PM +0100, Lothar Wa?mann wrote:
> > > The mxs-dma unit is also available on i.MX6UL. Make it possible to
> > > select it in Kconfig.
> > 
> > It should be dmaengine:xxx
> > 
> > With that
> > 
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
> I think this can go separately via dma tree.

Okay, pls resend :)

-- 
~Vinod
