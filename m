From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 12 Aug 2011 18:26:38 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix wrong devname to support clkdev
In-Reply-To: <1311671562-1483-1-git-send-email-jhbird.choi@samsung.com>
References: <1311671562-1483-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <007401cc58d1$f1a7fff0$d4f7ffd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jhbird.choi at samsung.com wrote:
> 
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
> index 66494f2..8e9699e 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -520,7 +520,7 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 21),
>  	}, {
>  		.name		= "ac97",
> -		.id		= -1,
> +		.devname	= "samsung-ac97",
>  		.enable		= exynos4_clk_ip_peril_ctrl,
>  		.ctrlbit	= (1 << 27),
>  	}, {
> --
> 1.7.1

OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
