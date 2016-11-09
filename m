From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 15:43:54 -0700
Subject: [PATCH] ARM: dts: am335x-baltos-ir5221: use both musb channels
 in host mode
In-Reply-To: <1476860943-30994-1-git-send-email-yegorslists@googlemail.com>
References: <1476860943-30994-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <20161109224354.GL2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* yegorslists at googlemail.com <yegorslists@googlemail.com> [161019 00:10]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  arch/arm/boot/dts/am335x-baltos-ir5221.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
> index d0faa7b..f599350 100644
> --- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
> +++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
> @@ -114,7 +114,7 @@
>  
>  &usb1 {
>  	status = "okay";
> -	dr_mode = "otg";
> +	dr_mode = "host";
>  };
>  
>  &cpsw_emac0 {

Applying into omap-for-v4.10/dt thanks.

Tony
