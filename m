From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 26 Jun 2018 00:46:55 +0900
Subject: [PATCH v2 1/2] arm64: dts: uniphier: add headphone detect gpio
 for LD20 global board
In-Reply-To: <20180625034505.1404-1-suzuki.katsuhiro@socionext.com>
References: <20180625034505.1404-1-suzuki.katsuhiro@socionext.com>
Message-ID: <CAK7LNARnMkTj3i=P80uiikhuD8xnX1wD85S9RRyFZzQ1BafpEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-06-25 12:45 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds GPIO for headphone detection on LD20 global board.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Applied.  Thanks!

> ---
>  arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> index 6a074a20c924..8aeb59486ff2 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> @@ -60,6 +60,7 @@
>                         &i2s_port4
>                         &spdif_port0
>                         &comp_spdif_port0>;
> +               hp-det-gpio = <&gpio UNIPHIER_GPIO_IRQ(0) GPIO_ACTIVE_LOW>;
>         };
>
>         spdif-out {
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
