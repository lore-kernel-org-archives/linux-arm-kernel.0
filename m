From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 05 Jul 2017 11:26:24 +0900
Subject: [PATCH] ARM: dts: zte: remove num-slots from zx296702-ad1
In-Reply-To: <1499160677-78463-1-git-send-email-shawn.lin@rock-chips.com>
References: <CGME20170704093157epcas4p3c6170646822ad9462a90942c50eb2007@epcas4p3.samsung.com>
 <1499160677-78463-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <f65b6cb1-0111-2dea-0392-f9168494b44d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2017 06:31 PM, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
> 
>  arch/arm/boot/dts/zx296702-ad1.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
> index 081f980..b0183c3 100644
> --- a/arch/arm/boot/dts/zx296702-ad1.dts
> +++ b/arch/arm/boot/dts/zx296702-ad1.dts
> @@ -18,7 +18,6 @@
>  };
>  
>  &mmc0 {
> -	num-slots = <1>;
>  	supports-highspeed;
>  	non-removable;
>  	disable-wp;
> @@ -31,7 +30,6 @@
>  };
>  
>  &mmc1 {
> -	num-slots = <1>;
>  	supports-highspeed;
>  	non-removable;
>  	disable-wp;
> 
