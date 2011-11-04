From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 5 Nov 2011 00:20:54 +0100
Subject: [GIT PULL] Samsung devel-4 for v3.2
In-Reply-To: <027f01cc9ab6$2086eae0$6194c0a0$%kim@samsung.com>
References: <027f01cc9ab6$2086eae0$6194c0a0$%kim@samsung.com>
Message-ID: <201111050020.55071.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 November 2011, Kukjin Kim wrote:
> As we talked in Prague, I'm sending 'pull request for v3.2' Samsung-devel4
> which includes supporting EXYNOS4 DT, SPI clkdev and reorganization
> arch/arm/mach-exynos and small things.
> 
> Please pull from: 
>   git://github.com/kgene/linux-samsung.git next-samsung-devel-4
> 
> As a note, the branch includes arm-soc/next/cleanup3 and arm-soc/next/devel2
> based on mainline commit 994c0e99 ("Merge branch 'next/soc' of
> git://git.linaro.org/people/arnd/arm-soc") because it is needed for this and
> they include all of Samsung stuff for v3.2.
> 
> And I will be back to kernel.org after this merge window.
> 
> If any problems, please let me know.

I've looked through it, and I think I'll hold off for this merge window,
especially given that I had enough trouble with the the other commits
and that the submission is really late. Please realize that I have to
push back on stuff that comes during the merge window.

Please send the contents split up into separate branches (dt, spi, clkdev,
rename, devel) for 3.3. I think it's ok if you want to send just the
rename patch for 3.2 the way we had discussed earlier, because this kind
of patch really makes sense at the end of the merge window.

	Arnd
