From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 22:30:09 +0200
Subject: [GIT PULL] Samsung boards for v3.2
In-Reply-To: <001a01cc76b8$208e52c0$61aaf840$%kim@samsung.com>
References: <001a01cc76b8$208e52c0$61aaf840$%kim@samsung.com>
Message-ID: <201109202230.09426.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 September 2011, Kukjin Kim wrote:
> Please pull from:
>   git://github.com/kgene/linux-samsung.git next-samsung-board
> 
> As you see, the next-samsung-board includes new board, SMDK4212. Of course
> to support new SoC, EXYNOS4212 is required for it but current
> arch/arm/mach-exynos4 (ARCH_EXYNOS4) can support it so I merged it into
> next-samsung-board not next-samsung-soc and to support handling of cupid and
> rev. in Samsung stuff for it. As I remember, you said -soc branch of arm-soc
> is for adding new architecture like arch/arm/mach-xxxx.
> 
> As a note, this includes samsung-fixes-2 which has been already pulled in
> your tree too.

Looks good. I had to apply the same atag_offset change to the new board
file that was done in all other branches as well.

Pulled into next/board. Thanks!

	Arnd
