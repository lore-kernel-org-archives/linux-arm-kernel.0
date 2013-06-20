From: csd@broadcom.com (Christian Daudt)
Date: Thu, 20 Jun 2013 14:14:13 -0700
Subject: [PATCH] ARM: dts: bcm281xx: change comment to C89 style
In-Reply-To: <1370976358-18014-1-git-send-email-matt.porter@linaro.org>
References: <1370976358-18014-1-git-send-email-matt.porter@linaro.org>
Message-ID: <51C370A5.3020900@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-11 11:45 AM, Matt Porter wrote:
> CodingStyle does not allow C99 style comments. Since the
> dts files live in the kernel for now, make this compliant.
>
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> Acked-by: Christian Daudt <csd@broadcom.com>
> ---
>   arch/arm/boot/dts/bcm11351.dtsi |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 824bebe..0651a72 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -36,7 +36,7 @@
>   
>   	smc at 0x3404c000 {
>   		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
> -		reg = <0x3404c000 0x400>; //1 KiB in SRAM
> +		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
>   	};
>   
>   	uart at 3e000000 {
applied for for-3.11/dt
  thanks,
    csd
