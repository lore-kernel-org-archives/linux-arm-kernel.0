From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Jun 2014 20:50:32 +0200
Subject: [GIT PULL] Samsung fixes-1 for 3.16
In-Reply-To: <53A69238.5070709@samsung.com>
References: <53A69238.5070709@samsung.com>
Message-ID: <6202115.rEhZ2ZRvNc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 June 2014 17:22:16 Kukjin Kim wrote:
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>    Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/samsung-fixes-1
> 
> for you to fetch changes up to 7cbcb9d46f9194eb1f88c253a08c0292b2883acc:
> 
>    ARM: EXYNOS: Don't rely on firmware's secondary_cpu_start for mcpm 
> (2014-06-21 19:30:53 +0900)
> 
> ----------------------------------------------------------------
> Samsung fixes for 3.16
> 
> - use WFI macro in platform_do_lowpower because exynos cpuhotplug
>    includes a hardcoded WFI instruction and it causes compile error
>    in Thumb-2 mode.
> - fix GIC reg sizes for exynos4 SoCs
> - remove reset timer counter value during boot and resume for mct
>    to fix a big jump in printk timestamps
> - fix pm code to check cortex-A9 for another exynos SoCs
> - don't rely on firmware's secondary_cpu_start for mcpm
> 

Pulled into fixes branch, thanks!

	Arnd
