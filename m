From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 18 Oct 2013 07:15:01 -0700
Subject: [GIT PULL v2] Samsung-fixes for v3.12
In-Reply-To: <525DC20D.4080302@samsung.com> (Kukjin Kim's message of "Wed, 16
 Oct 2013 07:30:37 +0900")
References: <525DC20D.4080302@samsung.com>
Message-ID: <87ppr2wtqy.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene.kim@samsung.com> writes:

> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-fixes-v2
>
> for you to fetch changes up to 22c98592094e6c149b05cc13d4d6ec495e6f5879:
>
>   ARM: dts: fix PL330 MDMA1 address in DT for Universal C210 board
> (2013-10-16 07:25:41 +0900)
>
> ----------------------------------------------------------------
> Fixes for v3.12
> - correct typo 'samsung,pin-drv'
> - correct typo 'earlyprintk'
> - cpufreq regulator lookup for exynos4210-origen and trats
> - fix PL330 MDMA1 address for universal c210 board

These don't appear to be regressions, so since it's a bit late, I'm
queuing these up in fixes-non-critical.

Kevin
