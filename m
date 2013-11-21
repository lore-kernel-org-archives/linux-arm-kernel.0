From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Nov 2013 10:46:54 +0000
Subject: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
In-Reply-To: <20131118192256.GU10317@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
 <20131118181110.GM10317@atomide.com>
 <20131118190921.GT13640@lee--X1>
 <20131118192256.GU10317@atomide.com>
Message-ID: <20131121104654.GA23067@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [131118 11:10]:
> > > > Are you Acking this patch by the way?
> > > 
> > > If this looks acceptable to you guys, I'd like to merge this via my fixes
> > > branch this week with your acks if that works for you. That way I can base
> > > my omap legacy platform data removal patches on my fixes branch while keep
> > > things working for the drivers. Alternatively I can naturally base my
> > > legacy data removal on -rc2 too if this gets merged to mainline by then 
> > > via the MFD tree.
> > 
> > I can either send it up for the -rcs, or I can create an immutable
> > branch for you to pull from. That way the patch can do in via ARM-SoC
> > and MFD and we can let Git sort it out.
> 
> OK great, I'd prefer an immutable branch that I can merge in too. Then
> you can bundle it with other MFD fixes for the -rc series and send it
> in when it suits you :)

https://git.linaro.org/gitweb?p=people/ljones/mfd.git;a=shortlog;h=refs/heads/for-mfd-fixes

Here Tony, you can take this one.

I will simply apply my other fixes on top of it.

The issue is, I will most likely have to rebase it on top of -rc1 prior
to sending a request to Linus, so in that regard it's not exactly
immutable.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
