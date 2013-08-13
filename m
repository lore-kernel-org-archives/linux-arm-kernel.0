From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 13 Aug 2013 16:42:48 +0100
Subject: [PATCH 16/22] ARM: dts: Remove '0x's from OMAP3430 SDP DTS file
In-Reply-To: <1374490361-25769-16-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-16-git-send-email-lee.jones@linaro.org>
Message-ID: <20130813154248.GD15278@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Benoit,

Poke

On Mon, 22 Jul 2013, Lee Jones wrote:

> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/omap3430-sdp.dts | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
> index e2249bc..281914e 100644
> --- a/arch/arm/boot/dts/omap3430-sdp.dts
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -84,15 +84,15 @@
>  			label = "bootloader-nor";
>  			reg = <0 0x40000>;
>  		};
> -		partition at 0x40000 {
> +		partition at 40000 {
>  			label = "params-nor";
>  			reg = <0x40000 0x40000>;
>  		};
> -		partition at 0x80000 {
> +		partition at 80000 {
>  			label = "kernel-nor";
>  			reg = <0x80000 0x200000>;
>  		};
> -		partition at 0x280000 {
> +		partition at 280000 {
>  			label = "filesystem-nor";
>  			reg = <0x240000 0x7d80000>;
>  		};
> @@ -125,19 +125,19 @@
>  			label = "xloader-nand";
>  			reg = <0 0x80000>;
>  		};
> -		partition at 0x80000 {
> +		partition at 80000 {
>  			label = "bootloader-nand";
>  			reg = <0x80000 0x140000>;
>  		};
> -		partition at 0x1c0000 {
> +		partition at 1c0000 {
>  			label = "params-nand";
>  			reg = <0x1c0000 0xc0000>;
>  		};
> -		partition at 0x280000 {
> +		partition at 280000 {
>  			label = "kernel-nand";
>  			reg = <0x280000 0x500000>;
>  		};
> -		partition at 0x780000 {
> +		partition at 780000 {
>  			label = "filesystem-nand";
>  			reg = <0x780000 0x7880000>;
>  		};
> @@ -170,19 +170,19 @@
>  			label = "xloader-onenand";
>  			reg = <0 0x80000>;
>  		};
> -		partition at 0x80000 {
> +		partition at 80000 {
>  			label = "bootloader-onenand";
>  			reg = <0x80000 0x40000>;
>  		};
> -		partition at 0xc0000 {
> +		partition at c0000 {
>  			label = "params-onenand";
>  			reg = <0xc0000 0x20000>;
>  		};
> -		partition at 0xe0000 {
> +		partition at e0000 {
>  			label = "kernel-onenand";
>  			reg = <0xe0000 0x200000>;
>  		};
> -		partition at 0x2e0000 {
> +		partition at 2e0000 {
>  			label = "filesystem-onenand";
>  			reg = <0x2e0000 0xfd20000>;
>  		};

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
