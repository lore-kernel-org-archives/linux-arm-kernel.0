From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 3 Sep 2015 15:38:10 +0200
Subject: [PATCH] ARM: ux500: fix typo in regulator names
In-Reply-To: <1438777340-27511-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438777340-27511-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAAObsKA8bYFe903SP1M+fRW4XRNuUbheLM+gwt_0vVM5M_db+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2015 at 14:22, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Apparently an extra _reg suffix was appended to the end of the names of
> regulators ab8500_ext2_reg and ab8500_ext3_reg.

Just pinging in case there's any interest in getting this fixed.

Regards,

Tomeu

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
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
