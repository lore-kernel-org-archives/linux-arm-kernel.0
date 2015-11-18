From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 18 Nov 2015 17:18:33 +0300
Subject: [PATCH v3 1/5] ARM: dts: rockchip: rk3288-veyron: rename pinctrl
 node reboot to reset
In-Reply-To: <1447840246-19744-1-git-send-email-andy.yan@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <1447840246-19744-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <564C88B9.3060109@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/18/2015 12:50 PM, Andy Yan wrote:

> rename pinctrl node reboot to reset to match it's lable name

    Label? BTW, I'm not seeing it on this node...

> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>
> ---
>
> Changes in v3:
>   - rename a pinctrl node in rk3288-veyron, the original name will be
>     used in the incoming reboot notifier driver
>
> Changes in v2: None
>
>   arch/arm/boot/dts/rk3288-veyron.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 2fa7a0d..292aaaf 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -495,7 +495,7 @@
>   		};
>   	};
>
> -	reboot {
> +	reset {
>   		ap_warm_reset_h: ap-warm-reset-h {
>   			rockchip,pins = <RK_GPIO0 13 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};

MBR, Sergei
