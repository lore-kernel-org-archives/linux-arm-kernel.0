From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 May 2014 07:49:44 -0700
Subject: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration
 when booted with device tree
In-Reply-To: <20140521092305.GE6679@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <20140521092305.GE6679@lee--X1>
Message-ID: <20140521144944.GF17417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lee Jones <lee.jones@linaro.org> [140521 02:24]:
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
> Okay, it looks like this series is good to go now.  If you believe so
> too, give me the nod and I'll apply.

Yes feel free to apply and merge the branch for v3.16. The
last patch in this series I can apply a bit later on as
a follow-up patch.

BTW, with these patches applied I've so far caught three PM
related regressions in other drivers ;) Was seeing much lower
power consumption with v3.14 compared to v3.15-rc so that's
why I preferred doing the patches against v3.14 in case
you were wondering. Anyways, fix is in the works to make
v3.15-rc power consumption to behave as well.

Regards,

Tony
