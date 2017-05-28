From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 May 2017 11:00:59 +0800
Subject: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
In-Reply-To: <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20170528030058.GC4528@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 11:58:47AM +0200, Daniel Lezcano wrote:
> diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
> index fb9a73a..4a4d2e2 100644
> --- a/arch/arm/mach-imx/epit.c
> +++ b/arch/arm/mach-imx/epit.c
> @@ -39,7 +39,7 @@
>  #define EPITCR_OM_TOGGLE		(1 << 22)
>  #define EPITCR_OM_CLEAR			(2 << 22)
>  #define EPITCR_OM_SET			(3 << 22)
> -#define EPITCR_CLKSRC_OFF		(0 << 24)
> +#define EPITCR_TIMER_OFF		(0 << 24)
>  #define EPITCR_CLKSRC_PERIPHERAL	(1 << 24)
>  #define EPITCR_CLKSRC_REF_HIGH		(1 << 24)
>  #define EPITCR_CLKSRC_REF_LOW		(3 << 24)

I do not think this change should be there.

Shawn
