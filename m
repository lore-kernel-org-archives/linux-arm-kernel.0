From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 11:20:38 +0200
Subject: [GIT PULL 2nd 2/4] Samsung DT 3rd updates for v4.3
In-Reply-To: <55CBE0F2.4020104@kernel.org>
References: <55CBE0F2.4020104@kernel.org>
Message-ID: <20150813092038.GC30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 09:12:34AM +0900, Kukjin Kim wrote:
> Hi Arnd, Olof, Kevin
> 
> This is based on tags/samsung-dt-2 and including exynos4 related clock
> changes to support cpufreq-dt driver for exynos4 SoCs. Note that I've
> created one more clk topic branch called v4.3-topic/clk-samsung-2 based
> on previous one has been merged by Mike into clock tree before but I'm
> not sure new one merged into clk tree that's why I've noted its merge in
> this signed tag.

Since this depends on the previous DT branch that I asked for a respin, please
do it all over and send a fresh pull request that we hopefully can include.

We normally ask that you don't queue up merge requests like these for that
reason: If there's need to redo an earlier branch there's a lot of work that
needs to be done on your side. Instead, please wait until previous pull request
has been merged before you send the next one. Thanks!


-Olof
