From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 May 2013 12:13:42 +0530
Subject: [PATCH 31/39] dmaengine: ste_dma40: Replace ST-E's home-brew
 DMA direction defs with generic ones
In-Reply-To: <20130516070638.GC3269@gmail.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-32-git-send-email-lee.jones@linaro.org>
 <20130516051701.GG27639@intel.com>
 <20130516070638.GC3269@gmail.com>
Message-ID: <20130516064342.GI14863@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 08:06:38AM +0100, Lee Jones wrote:
> On Thu, 16 May 2013, Vinod Koul wrote:
> 
> > On Wed, May 15, 2013 at 10:51:54AM +0100, Lee Jones wrote:
> > > STEDMA40_*_TO_* direction definitions are identical in all but name to
> > > the pre-defined generic DMA_*_TO_* ones. Let's make things easy by not
> > > duplicating such things.
> > > 
> > > Cc: Vinod Koul <vinod.koul@intel.com>
> > > Cc: Dan Williams <djbw@fb.com>
> > > Cc: Per Forlin <per.forlin@stericsson.com>
> > > Cc: Rabin Vincent <rabin@rab.in>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Nice :)
> 
> :)
> 
> > 1) I dont see the STE macro getting removed, why do we need it
> 
> They are removed later in the set, once their use has been removed
> from platform code and all the other drivers.
> 
> > 2) last i checked the direction values had a bit idfference b/w what you are
> > using and what dmaengine defines, so hopefully that is taken care of..
> 
> Yes, no problem.
> 
> <place Ack here> ;)
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
> 
> -- 
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
