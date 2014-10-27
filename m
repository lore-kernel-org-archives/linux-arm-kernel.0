From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 27 Oct 2014 14:20:30 +0100
Subject: [PATCH] mmc: sunxi: Remove unused includes of linux/clk-private.h
In-Reply-To: <1412351606-29453-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1412351606-29453-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAPDyKFrp0cqUhH-2XUhCiMdWonb6TJ_v6TA9568KUKEx5=CGDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 October 2014 17:53, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 024f67c..647955d 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -21,7 +21,6 @@
>  #include <linux/err.h>
>
>  #include <linux/clk.h>
> -#include <linux/clk-private.h>
>  #include <linux/clk/sunxi.h>
>
>  #include <linux/gpio.h>
> --
> 1.9.3
>
