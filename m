From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 13 Aug 2015 19:11:04 +0900
Subject: [GIT PULL 2nd 2/4] Samsung DT 3rd updates for v4.3
In-Reply-To: <20150813092038.GC30160@localhost>
References: <55CBE0F2.4020104@kernel.org> <20150813092038.GC30160@localhost>
Message-ID: <005101d0d5b0$5d4333b0$17c99b10$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Thu, Aug 13, 2015 at 09:12:34AM +0900, Kukjin Kim wrote:
> > Hi Arnd, Olof, Kevin
> >
> > This is based on tags/samsung-dt-2 and including exynos4 related clock
> > changes to support cpufreq-dt driver for exynos4 SoCs. Note that I've
> > created one more clk topic branch called v4.3-topic/clk-samsung-2 based
> > on previous one has been merged by Mike into clock tree before but I'm
> > not sure new one merged into clk tree that's why I've noted its merge in
> > this signed tag.
> 
> Since this depends on the previous DT branch that I asked for a respin, please
> do it all over and send a fresh pull request that we hopefully can include.
> 
Yes, will make a fresh pull request for the exynos cpufreq-dt driver.

> We normally ask that you don't queue up merge requests like these for that
> reason: If there's need to redo an earlier branch there's a lot of work that
> needs to be done on your side. Instead, please wait until previous pull request
> has been merged before you send the next one. Thanks!
> 
Yeah, you're right. Actually, it was hard to handle it because of dependencies
of clk and cpufreq...Anyway I'll keep in mind what you suggested.

Thanks,
Kukjin
