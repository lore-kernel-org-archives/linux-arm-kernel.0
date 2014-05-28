From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 May 2014 08:03:52 +0100
Subject: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration
 when booted with device tree
In-Reply-To: <20140527171351.GA18063@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <20140527165234.GF4227@lee--X1>
 <20140527171351.GA18063@atomide.com>
Message-ID: <20140528070352.GG4227@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Here's an updated set of patches to enable low-power idle modes
> > > for some omap3 boards when booted with device tree.
> > > 
> > > This series when applied on top of the patches in tread                                                                                                       
> > > "[PATCH 00/11] Fixes for omap PM for making omap3 DT only",
> > > or omap-for-v3.16/pm branch.
> > > 
> > > Lee, if these patches look OK to you, please feel free to 
> > > pick them, preferrably to the immutable branch you already
> > > have set up so I can also merge them in to be able to have
> > > things working in my branch properly for PM.
> > 
> > Whoops, nearly forgot about this patchset.
> > 
> > Tony, can you resend it with all your fix-ups please.  The 8< doesn't
> > work well with my patch application 'system'.
> 
> Sure I'll do that. FYI, these kind of patches should apply just
> fine when piped to git-am --scissors.

It's not that - the patches would apply just fine individually.
However my mailer stores the patches in date order, so when I use `git
am <mbox-folder>` it attempts to apply them OoO.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
