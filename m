From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 13 Nov 2014 12:32:42 +0100
Subject: [PATCH] ARM: at91/dt: Fix sama5d3x typos.
In-Reply-To: <ec77270840f94da6a6d7548e7a3bf5a8@EMAIL.axentia.se>
References: <ec77270840f94da6a6d7548e7a3bf5a8@EMAIL.axentia.se>
Message-ID: <546496DA.1000502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/2014 13:56, Peter Rosin :
>>From c23d712fe924b929c2eb39eba644fe74bcccfd37 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Date: Thu, 23 Oct 2014 13:52:03 +0200
> Subject: [PATCH] ARM: at91/dt: Fix sama5d3x typos.
> 
> The DT compatible strings also need binding documentation, but that is for
> someone else to write.

Well, documentation is already queued up for 3.18 in Linus' tree.. Here
is the commit:
02037a9719fa (ARM: at91: document Atmel SMART compatibles).

So I remove this comment and queue this patch up for at91-3.18-fixes.

Thanks for having catch the typo, bye.

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/sama5d31.dtsi   |    2 +-
>  arch/arm/boot/dts/sama5d33.dtsi   |    2 +-
>  arch/arm/boot/dts/sama5d34.dtsi   |    2 +-
>  arch/arm/boot/dts/sama5d35.dtsi   |    2 +-
>  arch/arm/boot/dts/sama5d36.dtsi   |    2 +-
>  arch/arm/boot/dts/sama5d3xcm.dtsi |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d31.dtsi b/arch/arm/boot/dts/sama5d31.dtsi
> index 7997dc9..883878b 100644
> --- a/arch/arm/boot/dts/sama5d31.dtsi
> +++ b/arch/arm/boot/dts/sama5d31.dtsi
> @@ -12,5 +12,5 @@
>  #include "sama5d3_uart.dtsi"
>  
>  / {
> -	compatible = "atmel,samad31", "atmel,sama5d3", "atmel,sama5";
> +	compatible = "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
>  };
> diff --git a/arch/arm/boot/dts/sama5d33.dtsi b/arch/arm/boot/dts/sama5d33.dtsi
> index 39f8322..4b4434a 100644
> --- a/arch/arm/boot/dts/sama5d33.dtsi
> +++ b/arch/arm/boot/dts/sama5d33.dtsi
> @@ -10,5 +10,5 @@
>  #include "sama5d3_gmac.dtsi"
>  
>  / {
> -	compatible = "atmel,samad33", "atmel,sama5d3", "atmel,sama5";
> +	compatible = "atmel,sama5d33", "atmel,sama5d3", "atmel,sama5";
>  };
> diff --git a/arch/arm/boot/dts/sama5d34.dtsi b/arch/arm/boot/dts/sama5d34.dtsi
> index 89cda2c..aa01573 100644
> --- a/arch/arm/boot/dts/sama5d34.dtsi
> +++ b/arch/arm/boot/dts/sama5d34.dtsi
> @@ -12,5 +12,5 @@
>  #include "sama5d3_mci2.dtsi"
>  
>  / {
> -	compatible = "atmel,samad34", "atmel,sama5d3", "atmel,sama5";
> +	compatible = "atmel,sama5d34", "atmel,sama5d3", "atmel,sama5";
>  };
> diff --git a/arch/arm/boot/dts/sama5d35.dtsi b/arch/arm/boot/dts/sama5d35.dtsi
> index d20cd71..16c39f4 100644
> --- a/arch/arm/boot/dts/sama5d35.dtsi
> +++ b/arch/arm/boot/dts/sama5d35.dtsi
> @@ -14,5 +14,5 @@
>  #include "sama5d3_tcb1.dtsi"
>  
>  / {
> -	compatible = "atmel,samad35", "atmel,sama5d3", "atmel,sama5";
> +	compatible = "atmel,sama5d35", "atmel,sama5d3", "atmel,sama5";
>  };
> diff --git a/arch/arm/boot/dts/sama5d36.dtsi b/arch/arm/boot/dts/sama5d36.dtsi
> index db58cad..e85139e 100644
> --- a/arch/arm/boot/dts/sama5d36.dtsi
> +++ b/arch/arm/boot/dts/sama5d36.dtsi
> @@ -16,5 +16,5 @@
>  #include "sama5d3_uart.dtsi"
>  
>  / {
> -	compatible = "atmel,samad36", "atmel,sama5d3", "atmel,sama5";
> +	compatible = "atmel,sama5d36", "atmel,sama5d3", "atmel,sama5";
>  };
> diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
> index f7d8583..56574c8 100644
> --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
> @@ -8,7 +8,7 @@
>   */
>  
>  / {
> -	compatible = "atmel,samad3xcm", "atmel,sama5d3", "atmel,sama5";
> +	compatible = "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200 rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs";
> 


-- 
Nicolas Ferre
