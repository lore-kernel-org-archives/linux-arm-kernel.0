From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 Mar 2012 10:21:49 -0800
Subject: [GIT PULL 4/4] Samsung devel-dma for v3.4
In-Reply-To: <4F5B7CA7.2010604@samsung.com>
References: <4F5B7CA7.2010604@samsung.com>
Message-ID: <20120310182149.GA656@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2012 at 08:09:11AM -0800, Kukjin Kim wrote:
> Hi Arnd, Olof,
> 
> This is for Samsung dma stuff for v3.4 and depends on following:
>   next/cleanup-use-static
>   next/cleanup-exynos-clock
> 
> Please pull from:

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/devel-samsung-dma
> 
> And conflicts will be happened in clock part. Here is my preferred
> resolution. The mach-exynos/clock.c can be removed with following:
> 
> arch/arm/mach-exynos/exynos-clock4.c

Hi,

given my feedback on the cleanup-exynos-clock pull request, I'm holding off on
this one waiting on you to do the resolution of the conflicts. :-)


Thanks,

-Olof
