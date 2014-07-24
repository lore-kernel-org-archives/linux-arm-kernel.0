From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 25 Jul 2014 00:33:24 +0200
Subject: [PATCH] ARM: dts: Build dtbs for Rockchip boards
In-Reply-To: <1406240270-13278-1-git-send-email-dianders@chromium.org>
References: <1406240270-13278-1-git-send-email-dianders@chromium.org>
Message-ID: <7536612.LCojB7a6aY@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. Juli 2014, 15:17:50 schrieb Doug Anderson:
> This allows the "make dtbs" target to work.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

I'll add it to my rk3288-branch


Thanks
Heiko

> ---
> This is built upon (ARM: dts: add rk3288 evaluation board) at
> <https://patchwork.kernel.org/patch/4579541/>, which won't actually
> build without the bindings that just landed in today's clk-next.
> 
>  arch/arm/boot/dts/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 82f498b..026f61d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -341,6 +341,11 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8084-mtp.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += \
> +	rk3066a-bqcurie2.dtb \
> +	rk3188-radxarock.dtb \
> +	rk3288-evb-act8846.dtb \
> +	rk3288-evb-rk808.dtb
>  dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
>  dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
>  	s3c6410-smdk6410.dtb
