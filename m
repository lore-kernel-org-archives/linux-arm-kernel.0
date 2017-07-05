From: jun.nie@linaro.org (Jun Nie)
Date: Wed, 5 Jul 2017 09:26:05 +0800
Subject: [PATCH] ARM: dts: zte: remove num-slots from zx296702-ad1
In-Reply-To: <1499160677-78463-1-git-send-email-shawn.lin@rock-chips.com>
References: <1499160677-78463-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <CABymUCO1O0V9PWqb=0vKqXS=Jm688uis9oJ-EvHxEBeJ2Es87A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-07-04 17:31 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com>:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  arch/arm/boot/dts/zx296702-ad1.dts | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
> index 081f980..b0183c3 100644
> --- a/arch/arm/boot/dts/zx296702-ad1.dts
> +++ b/arch/arm/boot/dts/zx296702-ad1.dts
> @@ -18,7 +18,6 @@
>  };
>
>  &mmc0 {
> -       num-slots = <1>;
>         supports-highspeed;
>         non-removable;
>         disable-wp;
> @@ -31,7 +30,6 @@
>  };
>
>  &mmc1 {
> -       num-slots = <1>;
>         supports-highspeed;
>         non-removable;
>         disable-wp;
> --
> 1.9.1
>
>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
