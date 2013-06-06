From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Jun 2013 16:39:07 +0900
Subject: [GIT PULL 0/5] Renesas ARM based SoC cleanups for v3.11
In-Reply-To: <1370503703-31024-1-git-send-email-horms+renesas@verge.net.au>
References: <1370503703-31024-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130606073907.GB19336@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies,

I thought I had testes this but I have discovered a build problem in the
soc branch relating to the absence of a clean-up patch. I will reshuffle
this pull request and the one for soc and repost.

On Thu, Jun 06, 2013 at 04:28:18PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> 
>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.11
> 
> for you to fetch changes up to b9d02b5dc95bdbce73d0adceb1a3d20eb3068c8b:
> 
>   ARM: shmobile: marzen: keep local function as static (2013-06-06 14:14:13 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC cleanups for v3.11
> 
> * marzen: Make local function static
> * sh73a0: Use DEFINE_RES_MEM*() everywhere
> * r8a7778: Correct model number
> * Clean Up SH_CLK_SET_RATIO() and SH_FIXED_RATIO_CLK() macros
> * r8a7740: Make private clock arrays static
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (2):
>       ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
>       ARM: shmobile: marzen: keep local function as static
> 
> Laurent Pinchart (1):
>       ARM: shmobile: r8a7740: Make private clock arrays static
> 
> Sergei Shtylyov (1):
>       ARM: shmobile: r8a7778: correct model name in Kconfig
> 
> Simon Horman (1):
>       ARM: shmobile: sh73a0: Use DEFINE_RES_MEM*() everywhere
> 
>  arch/arm/mach-shmobile/Kconfig              |  2 +-
>  arch/arm/mach-shmobile/board-marzen.c       |  2 +-
>  arch/arm/mach-shmobile/clock-r8a7740.c      |  4 +-
>  arch/arm/mach-shmobile/include/mach/clock.h |  4 +-
>  arch/arm/mach-shmobile/setup-sh73a0.c       | 79 +++++------------------------
>  5 files changed, 19 insertions(+), 72 deletions(-)
> 
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
