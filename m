From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 14:50:48 -0800
Subject: [PATCH] ARM: dts: OMAP2420: Correct H4 board memory size
In-Reply-To: <1355517258-30745-1-git-send-email-jon-hunter@ti.com>
References: <1355517258-30745-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121214225048.GO4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121214 12:37]:
> The system memory node for the OMAP2420 H4 was incorrectly defined as
> start address followed by end address, instead of start address and
> size. No noticable side-effects were observed but fix this for
> correctness.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Tony
 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-h4.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
> index 77b84e1..9b0d077 100644
> --- a/arch/arm/boot/dts/omap2420-h4.dts
> +++ b/arch/arm/boot/dts/omap2420-h4.dts
> @@ -15,6 +15,6 @@
>  
>  	memory {
>  		device_type = "memory";
> -		reg = <0x80000000 0x84000000>; /* 64 MB */
> +		reg = <0x80000000 0x4000000>; /* 64 MB */
>  	};
>  };
> -- 
> 1.7.10.4
> 
