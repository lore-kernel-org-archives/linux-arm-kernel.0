From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 May 2014 10:13:52 -0700
Subject: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration
 when booted with device tree
In-Reply-To: <20140527165234.GF4227@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <20140527165234.GF4227@lee--X1>
Message-ID: <20140527171351.GA18063@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lee Jones <lee.jones@linaro.org> [140527 09:53]:
> > Here's an updated set of patches to enable low-power idle modes
> > for some omap3 boards when booted with device tree.
> > 
> > This series when applied on top of the patches in tread                                                                                                       
> > "[PATCH 00/11] Fixes for omap PM for making omap3 DT only",
> > or omap-for-v3.16/pm branch.
> > 
> > Lee, if these patches look OK to you, please feel free to 
> > pick them, preferrably to the immutable branch you already
> > have set up so I can also merge them in to be able to have
> > things working in my branch properly for PM.
> 
> Whoops, nearly forgot about this patchset.
> 
> Tony, can you resend it with all your fix-ups please.  The 8< doesn't
> work well with my patch application 'system'.

Sure I'll do that. FYI, these kind of patches should apply just
fine when piped to git-am --scissors.

Regards,

Tony
