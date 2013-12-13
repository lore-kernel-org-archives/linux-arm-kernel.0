From: bcm@fixthebug.org (Christian Daudt)
Date: Fri, 13 Dec 2013 00:06:45 -0800
Subject: [PATCH v4 8/8] ARM: dts: Specify clocks for timer on bcm11351
In-Reply-To: <1386271244-3927-9-git-send-email-tim.kryger@linaro.org>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
 <1386271244-3927-9-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYrqr_fYM1cmr46_KkPjkHGVZ4n6ZaGSE0tmufwA+t_+xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Specify the external clock label in the timer node.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 25ca128..1246885 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -95,7 +95,7 @@
>                 compatible = "brcm,kona-timer";
>                 reg = <0x35006000 0x1000>;
>                 interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <32768>;
> +               clocks = <&hub_timer_clk>;
>         };
>
>         gpio: gpio at 35003000 {
> --
> 1.8.0.1
>
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
