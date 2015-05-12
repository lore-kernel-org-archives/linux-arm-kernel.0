From: l.majewski@samsung.com (Lukasz Majewski)
Date: Tue, 12 May 2015 10:28:55 +0200
Subject: [PATCH] ARM: dts: Fix typo in trip point temperature for
 exynos5420/5440
In-Reply-To: <1430988887-6743-1-git-send-email-a.kesavan@samsung.com>
References: <1430988887-6743-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <20150512102855.340ebb31@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

> Remove the extra zero in the "cpu-crit-0" trip point for exynos5420
> and exynos5440.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-trip-points.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5440-trip-points.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi
> b/arch/arm/boot/dts/exynos5420-trip-points.dtsi index
> 5d31fc1..2180a01 100644 ---
> a/arch/arm/boot/dts/exynos5420-trip-points.dtsi +++
> b/arch/arm/boot/dts/exynos5420-trip-points.dtsi @@ -28,7 +28,7 @@
> trips { type = "active";
>  	};
>  	cpu-crit-0 {
> -		temperature = <1200000>; /* millicelsius */
> +		temperature = <120000>; /* millicelsius */
>  		hysteresis = <0>; /* millicelsius */
>  		type = "critical";
>  	};
> diff --git a/arch/arm/boot/dts/exynos5440-trip-points.dtsi
> b/arch/arm/boot/dts/exynos5440-trip-points.dtsi index
> 48adfa8..356e963 100644 ---
> a/arch/arm/boot/dts/exynos5440-trip-points.dtsi +++
> b/arch/arm/boot/dts/exynos5440-trip-points.dtsi @@ -18,7 +18,7 @@
> trips { type = "active";
>  	};
>  	cpu-crit-0 {
> -		temperature = <1050000>; /* millicelsius */
> +		temperature = <105000>; /* millicelsius */
>  		hysteresis = <0>; /* millicelsius */
>  		type = "critical";
>  	};

Abhilash, thanks for spotting this mistake.

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

Thanks Krzysztof for picking this fix during my absence :-)

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
