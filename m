From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 09 Sep 2014 10:28:36 +0200
Subject: [PATCH v2] ARM: dts: Add mshc aliases for rk3288
In-Reply-To: <1409785523-12209-1-git-send-email-dianders@chromium.org>
References: <1409785523-12209-1-git-send-email-dianders@chromium.org>
Message-ID: <18318098.Hm4yenW6Sf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 3. September 2014, 16:05:23 schrieb Doug Anderson:
> It's convenient (and less confusing to people reading logs) if the
> eMMC port on rk3288 is consistenly marked with mmc0 and the sdmmc port
> on rk3288 is consistently marked with mmc1.  Add the appropriate
> aliases.

Added to my v3.18-next/dts branch

> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
> ---
> 
> Changes in v2:
> - Use mshc aliases now
> - Adds sdio0/1 aliases since those are in the dts.
> 
>  arch/arm/boot/dts/rk3288.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 5f866e0..2c5d01f 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -29,6 +29,10 @@
>  		i2c3 = &i2c3;
>  		i2c4 = &i2c4;
>  		i2c5 = &i2c5;
> +		mshc0 = &emmc;
> +		mshc1 = &sdmmc;
> +		mshc2 = &sdio0;
> +		mshc3 = &sdio1;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
