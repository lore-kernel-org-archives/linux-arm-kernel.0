From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 14:51:59 -0700
Subject: [GIT PULL] berlin core changes for 4.18
In-Reply-To: <20180524155944.1de22147@xhacker.debian>
References: <20180524155944.1de22147@xhacker.debian>
Message-ID: <20180525215159.xo7tgssmoep73oct@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 24, 2018 at 03:59:44PM +0800, Jisheng Zhang wrote:
> Hi
> 
> Here is our mach-berlin changes for v4.18.
> 
> Thanks,
> Jisheng
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin-core-for-v4.18
> 
> for you to fetch changes up to eb14767c8a9117fdd84fc79e6263c85a4d8ec934:
> 
>   ARM: berlin: switch to SPDX license identifier (2018-05-24 14:49:09 +0800)
> 
> ----------------------------------------------------------------
> berlin core changes for v4.18
> 
> BG2CD SoC uses r3p0 Cortex-A9 MPCore single-CPU cluster. Autoselect
> pertinent errata, the SCU and the global timer, and allow use of the
> local timer on uniprocessor kernels.
> 
> remove non-necessary flush_cache_all() after scu_enable().
> 
> switch to SPDX license identifier for all files under mach-berlin/
> 
> ----------------------------------------------------------------
> Alexander Monakov (1):
>       ARM: berlin: extend BG2CD Kconfig entry
> 
> Jisheng Zhang (2):
>       arm: berlin: remove non-necessary flush_cache_all()
>       ARM: berlin: switch to SPDX license identifier

Merged, thanks!

Watch out for consistency on the patch subjects, please.

Also, you're cutting it a bit close w.r.t. merge window opening. If you can get
your pull requests in before -rc6 you run less risk of missing it if there's
a problem with it that needs a respin.




-Olof
