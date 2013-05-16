From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 May 2013 11:59:59 +0100
Subject: [PATCH 02/39] dmaengine: ste_dma40: Remove unnecessary call to
 d40_phy_cfg()
In-Reply-To: <20130516094014.GJ14863@intel.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-3-git-send-email-lee.jones@linaro.org>
 <20130516063546.GD14863@intel.com>
 <20130516072557.GD3269@gmail.com>
 <20130516094014.GJ14863@intel.com>
Message-ID: <20130516105959.GI3269@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 May 2013, Vinod Koul wrote:

> On Thu, May 16, 2013 at 08:25:57AM +0100, Lee Jones wrote:
> > On Thu, 16 May 2013, Vinod Koul wrote:
> > 
> > > On Wed, May 15, 2013 at 10:51:25AM +0100, Lee Jones wrote:
> > > > All configuration left in d40_phy_cfg() is runtime configurable and
> > > > there is already a call into it from d40_runtime_config(), so let's
> > > > rely on that.
> > > > 
> > > > Acked-by: Vinod Koul <vnod.koul@intel.com>
> > > That needs up update!
> > 
> > Ah, where did I get that from that?
> > 
> > Was that my mistake, or was this in the MAINTAINERS file?
> Certainly not in MAINTAINERS file :)

My bad then, sorry.

Linus,

Would you be kind enough to fix it please, as it's in your tree now.
-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
