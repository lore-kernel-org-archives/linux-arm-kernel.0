From: csd@broadcom.com (Christian Daudt)
Date: Mon, 22 Jul 2013 15:05:04 -0700
Subject: [PATCH 06/22] ARM: dts: bcm281xx: Remove '0x's from
 BCM11351 DTS file
In-Reply-To: <1374490361-25769-6-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-6-git-send-email-lee.jones@linaro.org>
Message-ID: <51EDAC90.6010108@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-22 03:52 AM, Lee Jones wrote:
> Cc: Christian Daudt <csd@broadcom.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/bcm11351.dtsi | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index c0cdf66..db5873a 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -34,7 +34,7 @@
>   		      <0x3ff00100 0x100>;
>   	};
>   
> -	smc at 0x3404c000 {
> +	smc at 3404c000 {
>   		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
>   		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
>   	};
> @@ -63,28 +63,28 @@
>   		clock-frequency = <32768>;
>   	};
>   
> -	sdio0: sdio at 0x3f180000 {
> +	sdio0: sdio at 3f180000 {
>   		compatible = "bcm,kona-sdhci";
>   		reg = <0x3f180000 0x10000>;
>   		interrupts = <0x0 77 0x4>;
>   		status = "disabled";
>   	};
>   
> -	sdio1: sdio at 0x3f190000 {
> +	sdio1: sdio at 3f190000 {
>   		compatible = "bcm,kona-sdhci";
>   		reg = <0x3f190000 0x10000>;
>   		interrupts = <0x0 76 0x4>;
>   		status = "disabled";
>   	};
>   
> -	sdio2: sdio at 0x3f1a0000 {
> +	sdio2: sdio at 3f1a0000 {
>   		compatible = "bcm,kona-sdhci";
>   		reg = <0x3f1a0000 0x10000>;
>   		interrupts = <0x0 74 0x4>;
>   		status = "disabled";
>   	};
>   
> -	sdio3: sdio at 0x3f1b0000 {
> +	sdio3: sdio at 3f1b0000 {
>   		compatible = "bcm,kona-sdhci";
>   		reg = <0x3f1b0000 0x10000>;
>   		interrupts = <0x0 73 0x4>;
Acked-by: Christian Daudt <csd@broadcom.com>

  Thanks,
    csd
