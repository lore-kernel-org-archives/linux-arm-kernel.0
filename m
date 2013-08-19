From: csd@broadcom.com (Christian Daudt)
Date: Mon, 19 Aug 2013 16:59:58 -0700
Subject: [PATCH 2/2] ARM: dts: add sdio blocks to bcm28155-ap board
In-Reply-To: <1375988874-11303-2-git-send-email-csd@broadcom.com>
References: <1375988874-11303-1-git-send-email-csd@broadcom.com>
 <1375988874-11303-2-git-send-email-csd@broadcom.com>
Message-ID: <5212B17E.70602@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-08 12:07 PM, Christian Daudt wrote:
> Enable sdio for bcm28155 AP board
>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
>
> diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
> index 0d66db6..4b0a3ec 100644
> --- a/arch/arm/boot/dts/bcm28155-ap.dts
> +++ b/arch/arm/boot/dts/bcm28155-ap.dts
> @@ -26,4 +26,20 @@
>   	uart at 3e000000 {
>   		status = "okay";
>   	};
> +
> +	sdio1: sdio at 3f180000 {
> +		max-frequency = <48000000>;
> +		status = "okay";
> +	};
> +
> +	sdio2: sdio at 3f190000 {
> +		non-removable;
> +		max-frequency = <48000000>;
> +		status = "okay";
> +	};
> +
> +	sdio4: sdio at 3f1b0000 {
> +		max-frequency = <48000000>;
> +		status = "okay";
> +	};
>   };
applied to bcm/for-3.12/dt

  thanks,
     csd
