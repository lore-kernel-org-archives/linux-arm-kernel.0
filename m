From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 Feb 2013 09:11:54 -0800
Subject: [PATCH v2 00/30] USB: omap-ehci: Move PHY management to PHY driver
In-Reply-To: <51122730.5030801@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <5110ECF3.7010908@ti.com> <20130205165851.GA1081@kroah.com>
 <20130205171743.GG25185@atomide.com> <51122730.5030801@ti.com>
Message-ID: <20130206171153.GY25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [130206 01:53]:
> On 02/05/2013 07:17 PM, Tony Lindgren wrote:
> > * Greg KH <gregkh@linuxfoundation.org> [130205 09:00]:
> >> On Tue, Feb 05, 2013 at 01:28:51PM +0200, Roger Quadros wrote:
> >>> Hi Tony & Greg,
> >>>
> >>> What's the best way to get these patches in?
> >>>
> >>> All patches have been acked by respective maintainers.
> >>>
> >>> If Tony can Ack the arch/arm/mach-omap2 stuff then should I send a
> >>> pull request directly to Greg? or the other way round?
> >>>
> >>> Tony, 
> >>> fyi, these patches should not interfere with the dw3c/musb stuff
> >>> sent by Felipe & Kishon.
> >>
> >> I'm fine with Tony just taking them all if he wants to.
> > 
> > OK. Roger, can you please do me a pull request with these
> > against v3.8-rc6?
> > 
> 
> Tony,
> 
> Since this depends on [1] and [2] which are both in linux-next, should
> I base it on linux-next?

Maybe you can base it on some commit in Greg's USB tree?
Just check with Greg that whatever you use as a base is an
immutable commit and OK to use as a base.
 
> Another option is to defer this to 3.10 merge window, along with the
> DT adaptation for OMAP USB Host.

Once you have a branch ready that builds and boots, let's see how
badly that conflicts with other branches we have queued up. If it's
trivial only, then maybe Greg can pick up the patches. If not, we
can still try to merge it in later on during the merge window as
it would be nice to get USB to usable point with DT.

Regards,

Tony
 
> [1] [PATCH v9 00/20] OMAP USB Host cleanup
> https://lkml.org/lkml/2013/1/23/155
> 
> [2] [PATCH v2 0/6] USB: Add support for multiple PHYs of same type
> https://lkml.org/lkml/2013/1/24/876
