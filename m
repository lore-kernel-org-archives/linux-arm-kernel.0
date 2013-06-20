From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 22:58:26 +0200
Subject: [GIT PULL 08/10] Samsung SoC EXYNOS5420 for v3.11
In-Reply-To: <51C0BC74.1060502@samsung.com>
References: <51C0BC74.1060502@samsung.com>
Message-ID: <201306202258.26968.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Kukjin Kim wrote:
> ----------------------------------------------------------------
> based on tags/common-clk-audio
> - add support for exynos5420 SoC
> 
> ----------------------------------------------------------------

This is causing me a little pain because of the deep dependency
chain. I'll probably have to create a next/soc2 branch, but
will first try to merge the Renesas pull requests, which may have
similar problems.

If it's possible to rebase this one not to have any dependencies
other than the branches merged into next/cleanup and next/soc,
I can pull it more easily, as long as I can figure out how
to merge it with the common-clk-audio branch.

	Arnd
