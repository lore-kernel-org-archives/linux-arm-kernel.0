From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 08 Apr 2015 10:03:48 +0200
Subject: [PATCH 4/6] ARM: dts: OdroidXU3: Enable TMU at Exynos5422 base.
In-Reply-To: <1427387955-5129-5-git-send-email-linux.amoon@gmail.com>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-5-git-send-email-linux.amoon@gmail.com>
Message-ID: <20150408100348.58fdeade@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,

> This commit enables TMU IP block on the Exynos5422 OdroidXU3
> device.
> 
> Tested on OdroidXU3 board.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 25
> +++++++++++++++++++++++++ 1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> b/arch/arm/boot/dts/exynos5422-odroidxu3.dts index c8b3e3e..e1635b5
> 100644 --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -288,6 +288,31 @@
>  		#cooling-cells = <2>;
>  		cooling-levels = <0 90 130 170 230>;
>  	};
> +
> +	tmu at 10060000 {
> +		vtmu-supply = <&ldo10_reg>;
> +		status = "okay";
> +	};
> +
> +	tmu at 10064000 {
> +		vtmu-supply = <&ldo10_reg>;
> +		status = "okay";
> +	};
> +
> +	tmu at 10068000 {
> +		vtmu-supply = <&ldo10_reg>;
> +		status = "okay";
> +	};
> +
> +	tmu at 1006c000 {
> +		vtmu-supply = <&ldo10_reg>;
> +		status = "okay";
> +	};
> +
> +	tmu at 100a0000 {
> +		vtmu-supply = <&ldo10_reg>;
> +		status = "okay";
> +	};
>  };
>  
>  &hdmi {

This seems correct. However please consider my comment to the previous
patch.

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
