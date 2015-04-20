From: lee@kernel.org (Lee Jones)
Date: Mon, 20 Apr 2015 19:27:30 +0100
Subject: [PATCH 2/3] ARM: ux500: Enable GPIO regulator for SD-card for
 HREF boards
In-Reply-To: <1429538553-17366-3-git-send-email-ulf.hansson@linaro.org>
References: <1429538553-17366-1-git-send-email-ulf.hansson@linaro.org>
 <1429538553-17366-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20150420182730.GI3447@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Apr 2015, Ulf Hansson wrote:

> Fixes: c94a4ab7af3f ("ARM: ux500: Disable the MMCI gpio-regulator by default")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  arch/arm/boot/dts/ste-href.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
> index 8cf499a..744c1e3 100644
> --- a/arch/arm/boot/dts/ste-href.dtsi
> +++ b/arch/arm/boot/dts/ste-href.dtsi
> @@ -124,8 +124,6 @@
>  
>  			states = <1800000 0x1
>  				  2900000 0x0>;
> -
> -			status = "disabled";
>  		};

Seems weird to do this in a separate patch.

>  		// External Micro SD slot
