From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Jul 2013 04:58:19 -0700
Subject: [RFC 0/4] Cleanup PRM and CM regbit headers
In-Reply-To: <51C95839.6050307@ti.com>
References: <1372076143-12955-1-git-send-email-rnayak@ti.com>
 <20130625071428.GC5523@atomide.com> <51C95839.6050307@ti.com>
Message-ID: <20130704115819.GJ5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130625 01:49]:
> On Tuesday 25 June 2013 12:44 PM, Tony Lindgren wrote:
> >> Rajendra Nayak (4):
> >> >   ARM: OMAP2: PRM/CM: Cleanup unused header contents
> >> >   ARM: OMAP3: PRM/CM: Cleanup unused header contents
> >> >   ARM: OMAP4: PRM/CM: Cleanup unused header contents
> >> >   ARM: OMAP5: PRM/CM: Cleanup unused header contents
> >> > 
> >> >  arch/arm/mach-omap2/cm-regbits-24xx.h  |  317 ----
> >> >  arch/arm/mach-omap2/cm-regbits-33xx.h  |  758 ---------
> >> >  arch/arm/mach-omap2/cm-regbits-34xx.h  |  631 --------
> >> >  arch/arm/mach-omap2/cm-regbits-44xx.h  | 1557 -------------------
> >> >  arch/arm/mach-omap2/cm-regbits-54xx.h  | 1632 -------------------
> >> >  arch/arm/mach-omap2/prm-regbits-24xx.h |  246 ---
> >> >  arch/arm/mach-omap2/prm-regbits-33xx.h |  305 ----
> >> >  arch/arm/mach-omap2/prm-regbits-34xx.h |  480 ------
> >> >  arch/arm/mach-omap2/prm-regbits-44xx.h | 2225 --------------------------
> >> >  arch/arm/mach-omap2/prm-regbits-54xx.h | 2677 --------------------------------
> >> >  10 files changed, 10828 deletions(-)
> > If things build and work after applying this, I suggest we send them
> > as a clean-up branch right after -rc1.
> 
> They build fine, and I boot tested on the omap4/5 boards that I have too.
> (I had the out of tree clock data pulled in for omap5 before I did this
> cleanup).
> 
> > 
> > It seems that build testing and then randconfig testing
> > should be enough for these if they are unused and only
> > removal.
> 
> Right, I'll do more testing and even though they should just boot
> fine on the omap2/3 boards too since all thats removed is anyway
> unused, I will still do more sanity test before posting them on -rc1.

Looks like we have all the pending stuff merged already, this would
probably be a good time to post a pull request for these.

Tony
