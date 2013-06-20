From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Jun 2013 07:58:34 +0900
Subject: [GIT PULL 08/10] Samsung SoC EXYNOS5420 for v3.11
In-Reply-To: <201306202258.26968.arnd@arndb.de>
References: <51C0BC74.1060502@samsung.com> <201306202258.26968.arnd@arndb.de>
Message-ID: <25bc01ce6e09$b149fc20$13ddf460$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Tuesday 18 June 2013, Kukjin Kim wrote:
> > ----------------------------------------------------------------
> > based on tags/common-clk-audio
> > - add support for exynos5420 SoC
> >
> > ----------------------------------------------------------------
> 
> This is causing me a little pain because of the deep dependency
> chain.

Yeah could be, but I thought it's better to avoid useless merge conflicts...

> I'll probably have to create a next/soc2 branch, but
> will first try to merge the Renesas pull requests, which may have
> similar problems.
> 
> If it's possible to rebase this one not to have any dependencies
> other than the branches merged into next/cleanup and next/soc,
> I can pull it more easily, as long as I can figure out how
> to merge it with the common-clk-audio branch.
> 
I see, BTW as you can see, the common-clk-audio touches all of samsung dt
files to use '#include' instead of '/include/' so I couldn't remove the
dependencies :( sorry about that.

If anything is required, please kindly let me know.

Thanks,
- Kukjin
