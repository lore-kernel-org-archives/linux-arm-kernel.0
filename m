From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Jan 2015 15:46:00 -0800
Subject: [GIT PULL RE-SEND] Samsung fixes for v3.19
In-Reply-To: <54B685AE.5080508@kernel.org>
References: <54B38550.6010707@kernel.org>
 <20150112221131.GC22090@quad.lixom.net>
 <54B685AE.5080508@kernel.org>
Message-ID: <20150115234600.GA23775@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 12:05:18AM +0900, Kukjin Kim wrote:
> Hi,
> 
> Oops, it's totally my fault and mistake. Actually my git command for
> pull-request was correct but the git tool was old version :-( because
> there are two git in my laptop, anyway sorry for that and I'm resending
> with signed tag has been created before.
> 
> Please pull if you're OK with my comments on your questions below.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-fixes-3.19
> 
> for you to fetch changes up to 26d13bf77b8e59adf4953577ba48e1903545bf7f:
> 
>   ARM: exynos_defconfig: Enable LM90 driver (2015-01-12 17:16:32 +0900)
> 
> ----------------------------------------------------------------
> Samsung fixes for v3.19
> - exynos_defconfig: enable LM90 driver and display panel support
>    - HWMON
>    - SENSORS_LM90
>    - Direct Rendering Manager (DRM)
>    - DRM bridge registration and lookup framework
>    - Parade ps8622/ps8625 eDP/LVDS bridge
>    - NXP ptn3460 eDP/LVDS bridge
>    - Exynos Fully Interactive Mobile Display controller (FIMD)
>    - Panel registration and lookup framework
>    - Simple panels
>    - Backlight & LCD device support
> 
> - use pmu_system_controller phandle for dp phy
>   : DP PHY requires pmu_system_controller to handle PMU reg. now

Merged.


-Olof
