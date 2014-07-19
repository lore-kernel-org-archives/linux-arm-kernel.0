From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 Jul 2014 14:59:42 -0700
Subject: [GIT PULL 1/5] Samsung non-critical-fixes for v3.17
In-Reply-To: <53C9C121.6090403@samsung.com>
References: <53C9C121.6090403@samsung.com>
Message-ID: <20140719215942.GC15676@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 19, 2014 at 09:51:45AM +0900, Kukjin Kim wrote:
> The following changes since commit 1795cd9b3a91d4b5473c97f491d63892442212ab:
> 
>   Linux 3.16-rc5 (2014-07-13 14:04:33 -0700)
> 
> are available in the git repository at:
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/fixes-for-3.17
> 
> for you to fetch changes up to 042b687f880adcca77847688aac35e2e16927944:
> 
>   ARM: EXYNOS: Fix build breakge with PM_SLEEP=n (2014-07-19
> 04:45:02 +0900)
> 
> ----------------------------------------------------------------
> Samsung non critical fixes for v3.17
> - update exynos_defconfig for remove outdated configs and
> enable most of the configs used on latest exynos platforms
> - fix build breakge for exynos_defconfig with PM_SLEEP=n

Hi,

We now separate out defconfigs (as you might have noticed if you looked
at our tree). I don't see any dependencies between these changes and
the rest so I'll cherry-pick the patches into fixes-non-critical (for
the build fix) and defconfig for that patch.

-Olof
