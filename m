From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 22 Jul 2013 10:51:54 +0900
Subject: [PATCH 1/1] of/documentation: Fix a typo in exynos5250-clock.txt
In-Reply-To: <1373012281-26433-1-git-send-email-sachin.kamat@linaro.org>
References: <1373012281-26433-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <0ab501ce867e$0adadd40$209097c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> The clocks should be numbered sequentially as they are represented as
> enum values in the clock driver.
> 
> Typo introduced by commit 17d4caccef ("clk: exynos5250: register
> display block gate clocks to common clock framework")
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  .../devicetree/bindings/clock/exynos5250-clock.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> index 781a627..1a05761 100644
> --- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> @@ -154,7 +154,7 @@ clock which they consume.
>    dsim0			341
>    dp			342
>    mixer			343
> -  hdmi			345
> +  hdmi			344
> 
>  Example 1: An example of a clock controller node is listed below.
> 
> --
> 1.7.9.5

Looks OK to me.

Mike, do you want me to take into the samsung tree?

Thanks,
Kukjin
