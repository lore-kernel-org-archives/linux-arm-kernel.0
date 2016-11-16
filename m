From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 16 Nov 2016 13:42:28 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: add the sdmmc pinctrl for rk1108
In-Reply-To: <1479024799-29198-1-git-send-email-jacob-chen@iotwrt.com>
References: <1479024799-29198-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <17426494.06vbuIDA0O@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 13. November 2016, 16:13:18 CET schrieb Jacob Chen:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
> 
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk1108.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk1108.dtsi b/arch/arm/boot/dts/rk1108.dtsi
> index 9dccfea..6a06ad7 100644
> --- a/arch/arm/boot/dts/rk1108.dtsi
> +++ b/arch/arm/boot/dts/rk1108.dtsi
> @@ -321,6 +321,31 @@
>  			input-enable;
>  		};
> 
> +        sdmmc {

I've fixed the intendation here (needed tabs instead of spaces) and moved the 
block to its alphabetically correct position between i2c and uart nodes and 
applied the result to my dts32 branch.


Thanks
Heiko
