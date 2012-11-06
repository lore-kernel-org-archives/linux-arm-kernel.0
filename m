From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Nov 2012 11:32:32 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <1351731731-8435-1-git-send-email-horms@verge.net.au>
References: <1351731731-8435-1-git-send-email-horms@verge.net.au>
Message-ID: <20121106023232.GP2944@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 09:02:08AM +0800, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following defconfig enhancements for 3.8.

Ping.

> I will work on the suggestions by Arnd to reduce the number
> of defconfigs for shmobile - in essence moving towards one or
> two generic configs rather than per-board configs. However,
> this seems to be somewhat non-trivial and in the mean time
> I would like to keep updating the existing defcoings.
> 
> ----------------------------------------------------------------
> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:
> 
>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git defconfig
> 
> for you to fetch changes up to 67e13cbb807c6b95706e4ec0ca2c068f14f25588:
> 
>   ARM: shmobile: leave CONFIG_INOTIFY_USER enabled by default (2012-11-01 08:51:34 +0800)
> 
> ----------------------------------------------------------------
> Guennadi Liakhovetski (1):
>       ARM: shmobile: leave CONFIG_INOTIFY_USER enabled by default
> 
> Kuninori Morimoto (2):
>       ARM: shmobile: mackerel: defconfig update
>       ARM: shmobile: armadillo800eva: enable L2X0 cache on defconfig
> 
>  arch/arm/configs/ap4evb_defconfig          |    1 -
>  arch/arm/configs/armadillo800eva_defconfig |    2 +-
>  arch/arm/configs/kota2_defconfig           |    1 -
>  arch/arm/configs/kzm9g_defconfig           |    1 -
>  arch/arm/configs/mackerel_defconfig        |   19 ++++++++++++++++---
>  5 files changed, 17 insertions(+), 7 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
