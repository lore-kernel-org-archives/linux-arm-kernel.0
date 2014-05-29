From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 May 2014 12:38:41 -0700
Subject: [GIT PULL 3rd 1/3] Samsung Exynos cpuidle updates for 3.16
In-Reply-To: <035601cf7897$6c959190$45c0b4b0$@samsung.com>
References: <035601cf7897$6c959190$45c0b4b0$@samsung.com>
Message-ID: <20140529193841.GF18481@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 01:03:17PM +0900, Kukjin Kim wrote:
> Note: merge conflict will be happened when pulling this for
> arch/arm/mach-exynos/cpuidle.
> You may just fixup with 'git rm arch/arm/mach-exynos/cpuidle.', it is due to
> 'removing inclusion of <plat/cpu.h>' before moving cpuidle driver into
> drivers/cpuidle...
> 
> - Kukjin
> 
> The following changes since commit 985326c9f65a4c1a3b5ab875e6ce0c97c39449ec:
> 
>   Merge branch 'v3.16-next/clk-samsung' into v3.16-next/cpuidle-exynos
> (2014-05-26 05:20:25 +0900)
> 
> are available in the git repository at:
> 
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/exynos-cpuidle
> 
> for you to fetch changes up to cd245f59aae5d6ef265f46aa6cea78354d61b629:
> 
>   ARM: EXYNOS: Fix kernel panic when unplugging CPU1 on exynos (2014-05-26
> 05:21:47 +0900)
> 
> ----------------------------------------------------------------
> Samsung exynos-cpuidle updates for v3.16
> 
> - From Daniel Lezcano:
>  This patchset relies on the cpm_pm notifier to initiate the
>  powerdown sequence operations from pm.c instead cpuidle.c.
>  Thus the cpuidle driver is no longer dependent from arch
>  specific code as everything is called from the pm.c file.
> 
> Note, this is based on tags/exnos-mcpm and tags/samsung-clk

Merged into next/drivers. Thanks.

-Olof
