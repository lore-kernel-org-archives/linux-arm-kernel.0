From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Apr 2013 19:52:16 +0900
Subject: [GIT PULL] Timer clean-ups for 3.10, Part 2
In-Reply-To: <20130417184827.GA22799@quad.lixom.net>
References: <516720B4.3000703@gmail.com>
 <20130413065056.GB14735@quad.lixom.net> <516C0257.8040103@gmail.com>
 <201304152320.28401.arnd@arndb.de> <20130417165742.GB8730@quad.lixom.net>
 <20130417184827.GA22799@quad.lixom.net>
Message-ID: <064301ce3ceb$f731a4d0$e594ee70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 

[...]

> > Hrm, this is now a total mess. I can pick up Rob's preferred resolution,
> > but merging that in on top of the exynos branches causes lots of
> conflicts
> > there as well.
> >
> > I might just have to rebuild the next/ branches in question to resolve
> > this.  Either that or bring the late/clksrc stuff into the same branch
> > as the exynos timer patches.
> 
> Ok, given the complex merge fixup by Arnd (I'm not sure it's a great
> idea to add the new code in the merge commit like that, by the way),
> I've chosen to go with that as a base for late/clksrc instead, and I've
> pushed a new rebased late/clksrc that contains Arnd's version of the
> resolutions instead of Rob's. Let me know if further fixups are needed,
> in particular on exynos4 since I lack hardware to test that side.
> 
Let me test it on exynos4 in this weekend then I'll let you know.

I hope it will not be late for you.

Thanks.

- Kukjin
