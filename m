From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 7 Jul 2013 19:04:53 +0530
Subject: amba-pl08x and 'get_signal' namespace collision/build error
In-Reply-To: <20130707123240.GO24642@n2100.arm.linux.org.uk>
References: <51C97F40.5030101@arm.com>
 <20130625184539.GB2718@n2100.arm.linux.org.uk>
 <20130626044842.GR23141@intel.com>
 <20130626081909.GD2718@n2100.arm.linux.org.uk>
 <20130626103930.GS23141@intel.com>
 <20130627094650.GC4283@n2100.arm.linux.org.uk>
 <CAOesGMgSPNggnBm=E3B774m7Ad_QMXdqvcGqRMxhap6dtpNtCg@mail.gmail.com>
 <20130705061802.GB10947@intel.com>
 <20130707123240.GO24642@n2100.arm.linux.org.uk>
Message-ID: <20130707133453.GC16653@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 07, 2013 at 01:32:40PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 05, 2013 at 11:48:02AM +0530, Vinod Koul wrote:
> > On Wed, Jul 03, 2013 at 11:27:12AM -0700, Olof Johansson wrote:
> > > This has now hit the mainline kernel, and several defconfigs (nhk815,
> > > lpc32xx and the spear ones) are broken there.
> > > 
> > > Vinod, when are you sending up your pull request with the fix? It'd be
> > > good to see it go in soon.
> > It should be on its way by the weekend
> 
> It still isn't in the tree.
I sent this morning, depends on how soon can linus merge this
> 
> Personally, I think that the fix should have come via my tree, because
> the breakage was caused my the changes in my tree - and for the last week
> or more I've not been able to build any of these ARM Ltd devel platforms
> because of this bug.
> 
> It also means that I'm not able to build test a load of changes I'm
> currently working on against a recent kernel (or indeed any v3.10 kernel.)
> In other words, the lack of this patch being merged is stopping me from
> doing my job properly.  (Consider from your perspective: if I were to
> break something you relied upon for a couple of weeks, how would you
> feel about it?)
> 
> Please get this fix into mainline ASAP - even if you have to send it as a
> patch separately to Linus rather than putting it as part of your normal
> pull request.
Yes it could have gone thur your tree as well, or you could have merged my tree
to resolve your breakage

--
Thanks
~Vinod
