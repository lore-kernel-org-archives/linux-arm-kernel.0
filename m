From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Feb 2013 21:29:01 -0800
Subject: [PATCH V3] ARM: EXYNOS: Add clocks for EXYNOS I2S and PCM I/F
In-Reply-To: <011201ce05db$82ae97e0$880bc7a0$@samsung.com>
References: <011201ce05db$82ae97e0$880bc7a0$@samsung.com>
Message-ID: <1e0c01ce09ab$09600b70$1c202250$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangsu Park wrote:
> 
> Audio Subsystem has own clocks for I2S0 and PCM0 in all EXYNOS series.
> This patch add clocks for I2S0 and PCM0 I/F.
> 
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile      |    1 +
>  arch/arm/mach-exynos/clock-audss.c |   68
> ++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/clock-audss.c
> 
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-
> exynos/Makefile
> index 7e53a3a..5b6c7c0 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -13,6 +13,7 @@ obj-				:=
>  # Core
> 
>  obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
> +obj-$(CONFIG_ARCH_EXYNOS)	+= clock-audss.o

Sorry for late response.

Basically, this should be implemented with common clock stuff but its
posting was delayed due to some reason :-( I think, you can see the patches
from Thomas P Abraham soon, so please re-work this based on that. If any
updates, let you know.

Thanks.

- Kukjin
