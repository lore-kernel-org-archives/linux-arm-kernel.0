From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 4 Sep 2015 13:48:30 +0200
Subject: [PATCH] ARM: ux500: fix typo in regulator names
In-Reply-To: <1438777340-27511-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438777340-27511-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAPDyKFqRz1QyfWXzcDde0J9Fc7gTZWQOFGNzU=2cg1JnMyrL+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2015 at 14:22, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Apparently an extra _reg suffix was appended to the end of the names of
> regulators ab8500_ext2_reg and ab8500_ext3_reg.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

You should probably include Linus Walleij as he is the maintainer of ux500.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  arch/arm/boot/dts/ste-snowball.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> index 32a5ccb14e7e..07c0e346942c 100644
> --- a/arch/arm/boot/dts/ste-snowball.dts
> +++ b/arch/arm/boot/dts/ste-snowball.dts
> @@ -360,11 +360,11 @@
>                                                 regulator-name = "ab8500-ext-supply1";
>                                         };
>
> -                                       ab8500_ext2_reg_reg: ab8500_ext2 {
> +                                       ab8500_ext2_reg: ab8500_ext2 {
>                                                 regulator-name = "ab8500-ext-supply2";
>                                         };
>
> -                                       ab8500_ext3_reg_reg: ab8500_ext3 {
> +                                       ab8500_ext3_reg: ab8500_ext3 {
>                                                 regulator-name = "ab8500-ext-supply3";
>                                         };
>                                 };
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
