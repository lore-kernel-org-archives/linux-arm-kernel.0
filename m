From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 10 Oct 2012 17:15:02 +0200
Subject: [PATCH 2/3] ARM: dts: Correcting size of memory defined for omap5
In-Reply-To: <1349870716-25511-3-git-send-email-lokeshvutla@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
 <1349870716-25511-3-git-send-email-lokeshvutla@ti.com>
Message-ID: <507590F6.3050702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2012 02:05 PM, Lokesh Vutla wrote:
> Memory present for omap5 is 2GB. But in dt file

omap5 -> OMAP5
dt -> dts

And this patch is about omap5-evm so you should be more specific in your
changelog and even in the subject:

ARM: dts: omap5-evm: Fix size of memory defined for EVM

> it is specified as 1GB. Correcting the same
> in this patch

No "patch" in the changelog, please add a dot at the end of a sentence
and make a correct sentence.

Regards,
Benoit

> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/boot/dts/omap5-evm.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> index 9c41a3f..6f87e1a 100644
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ b/arch/arm/boot/dts/omap5-evm.dts
> @@ -15,7 +15,7 @@
>  
>  	memory {
>  		device_type = "memory";
> -		reg = <0x80000000 0x40000000>; /* 1 GB */
> +		reg = <0x80000000 0x80000000>; /* 2 GB */
>  	};
>  
>  	vmmcsd_fixed: fixedregulator-mmcsd {
> 
