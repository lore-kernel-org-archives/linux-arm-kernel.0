From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 11 May 2010 09:57:49 +0200
Subject: SAMSUNG kernel tree merge plans
In-Reply-To: <20100510034937.GX26401@trinity.fluff.org>
References: <20100506054651.GL26401@trinity.fluff.org>
	<015f01caece8$723e1700$56ba4500$%szyprowski@samsung.com>
	<20100510034937.GX26401@trinity.fluff.org>
Message-ID: <001001caf0df$a920c1f0$fb6245d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, May 10, 2010 5:50 AM Ben Dooks wrote:

> > We would really like to merge as much as possible from our current
> > development tree:
> > http://git.infradead.org/users/kmpark/linux-2.6-
> samsung/shortlog/refs/heads/SPRC-2.6.34-rc5-opensource
> >
> > Some of the patches that we depend on are still in the review phase (s5p
> timer), some should be replaced by the ones that were
> > posted recently. Especially most of our patches depend on S5PV210 GPIO
> support, so without it we cannot go further. Is there any
> > chance to get it merged quickly? I will rebase our tree asap the
> mentioned patches get merged.
> 
> I'll sort out what can be merged from the items on the list, but I'm
> not going git-tree diving just at the moment. The firstset will be
> stuff for Russell's tree, for linus' tree there is a ltitle more time
> to get prepared.

Ok, I understand. I've separated the patches into different categories and
rebased onto your next-samsung. I hope this will help sorting out these
things.

Patches are available at:

http://git.infradead.org/users/kmpark/linux-2.6-samsung

branches:
next-samsung-s5p-fixes - various fixes for s5p SoCs
next-samsung-s5pv210 - new features for s5pv210 SoCs
next-samsung-s5pc1xx - s5pc1xx cleanup (to be discussed)
next-samsung-onenand - platform patch for onenand driver (requires all
above patches)

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
