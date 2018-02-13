From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Feb 2018 17:17:42 +0100
Subject: [PATCH 6/9] ARM: dts: kirkwood: Fix "debounce-interval" property
 misspelling
In-Reply-To: <1518531335-5170-7-git-send-email-geert+renesas@glider.be> (Geert
 Uytterhoeven's message of "Tue, 13 Feb 2018 15:15:32 +0100")
References: <1518531335-5170-1-git-send-email-geert+renesas@glider.be>
 <1518531335-5170-7-git-send-email-geert+renesas@glider.be>
Message-ID: <87d118q2xl.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,
 
 On mar., f?vr. 13 2018, Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> "debounce_interval" was never supported.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Applied on mvebu/fixes with the Reviewed-by flag from Andrew Lunn

Thanks,

Gregory

> ---
> Please apply to your tree when appropriate.
>
>  arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> index 5ce220ac9611fa78..5aa4669ae2548a8c 100644
> --- a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> +++ b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> @@ -35,7 +35,7 @@
>  		pinctrl-names = "default";
>  
>  		eject {
> -			debounce_interval = <50>;
> +			debounce-interval = <50>;
>  			wakeup-source;
>  			linux,code = <KEY_EJECTCD>;
>  			label = "Eject Button";
> -- 
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
