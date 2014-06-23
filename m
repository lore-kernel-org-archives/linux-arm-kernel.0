From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Mon, 23 Jun 2014 11:53:28 +0400
Subject: [PATCH] ARM: dts: exynos5410: Fill in CPU clock-frequency
In-Reply-To: <1403466596-3347-1-git-send-email-afaerber@suse.de>
References: <1403466596-3347-1-git-send-email-afaerber@suse.de>
Message-ID: <53A7DCF8.4090108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2014 11:49 PM, Andreas F?rber wrote:
> It's 1.6 GHz for the Cortex-A15.
>
> Avoids warnings like "/cpus/cpu at 0 missing clock-frequency property".
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>   arch/arm/boot/dts/exynos5410.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 3839c26..9d0b8cc 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -28,24 +28,28 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a15";
>   			reg = <0x0>;
> +			clock-frequency = <1600000000>;
>   

Reviewed-by: Tarek Dakhran<t.dakhran@samsung.com>

-- 
Best regards,
     Tarek Dakhran
