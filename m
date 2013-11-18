From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Nov 2013 11:33:59 -0800
Subject: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
In-Reply-To: <20131118192832.GU13640@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
 <20131118181110.GM10317@atomide.com>
 <20131118190921.GT13640@lee--X1>
 <20131118192256.GU10317@atomide.com>
 <20131118192832.GU13640@lee--X1>
Message-ID: <20131118193359.GV10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lee Jones <lee.jones@linaro.org> [131118 11:29]:
> On Mon, 18 Nov 2013, Tony Lindgren wrote:
> 
> > * Lee Jones <lee.jones@linaro.org> [131118 11:10]:
> > > > > Are you Acking this patch by the way?
> > > > 
> > > > If this looks acceptable to you guys, I'd like to merge this via my fixes
> > > > branch this week with your acks if that works for you. That way I can base
> > > > my omap legacy platform data removal patches on my fixes branch while keep
> > > > things working for the drivers. Alternatively I can naturally base my
> > > > legacy data removal on -rc2 too if this gets merged to mainline by then 
> > > > via the MFD tree.
> > > 
> > > I can either send it up for the -rcs, or I can create an immutable
> > > branch for you to pull from. That way the patch can do in via ARM-SoC
> > > and MFD and we can let Git sort it out.
> > 
> > OK great, I'd prefer an immutable branch that I can merge in too. Then
> > you can bundle it with other MFD fixes for the -rc series and send it
> > in when it suits you :)
> 
> That's fine. It's 19:30 here now and I still have a shed load of
> debugging to do, so I'll deal with this tomorrow if it's all the same
> to you?

Yeah sure I can wait few days no problem.

Thanks,

Tony
