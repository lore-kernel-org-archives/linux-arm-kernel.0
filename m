From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 24 Sep 2013 17:34:41 +0530
Subject: [PATCH 01/10] clk: bcm2835: Remove duplicate inclusion of
 clk-provider.h
In-Reply-To: <1379064232-10261-1-git-send-email-sachin.kamat@linaro.org>
References: <1379064232-10261-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAK9yfHwkf+J+vM8g=9HpQ-UsQ=p5N6iaSGfTNd_QotFkpsrD1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On 13 September 2013 14:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> clk-provider.h was included twice.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> ---
>  drivers/clk/clk-bcm2835.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
> index 5fb4ff5..676077d 100644
> --- a/drivers/clk/clk-bcm2835.c
> +++ b/drivers/clk/clk-bcm2835.c
> @@ -20,7 +20,6 @@
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
>  #include <linux/clk/bcm2835.h>
> -#include <linux/clk-provider.h>
>  #include <linux/of.h>
>
>  static const struct of_device_id clk_match[] __initconst = {
> --
> 1.7.9.5
>

Gentle ping on this series.

-- 
With warm regards,
Sachin
