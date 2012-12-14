From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Fri, 14 Dec 2012 19:23:09 +0100
Subject: [PATCH 1/1] ARM: OMAP3: igep0020: default boot status LED to On
 instead of Heartbeat
In-Reply-To: <1353745771-29983-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1353745771-29983-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAAwP0s2aTb5QzNopycuUMM=0Vj7OwDR9e1WaVCp5m+GvF-HHZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 9:29 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The IGEPv2 board uses an green GPIO LED to inform the user
> that the kernel could boot.
>
> The green status GPIO LED was default to Heartbeat but On
> is better to signal that is running correctly.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 0f24cb8..e526228 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -313,7 +313,7 @@ static struct gpio_led igep_gpio_leds[] = {
>         },
>         [3] = {
>                 .name                   = "gpio-led:green:d1",
> -               .default_trigger        = "heartbeat",
> +               .default_trigger        = "default-on",
>                 .gpio                   = -EINVAL, /* gets replaced */
>                 .active_low             = 1,
>         },
> --

Please ignore this patch since another one was sent that supersedes it.

Thanks a lot and sorry for the noise.
Javier
