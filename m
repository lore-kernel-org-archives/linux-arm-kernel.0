From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Oct 2015 21:02:58 +0100
Subject: [PATCH v8 06/17] dt-bindings: add document for analogix display
 port driver
In-Reply-To: <1446020793-10532-1-git-send-email-ykk@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446020793-10532-1-git-send-email-ykk@rock-chips.com>
Message-ID: <103292898.nCEg51kmfI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Mittwoch, 28. Oktober 2015, 16:26:33 schrieb Yakir Yang:
> diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
> index 7a3a9cd..9905081 100644
> --- a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
> +++ b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
> @@ -31,45 +31,31 @@ Required properties for dp-controller:
>  		from general PHY binding: the phandle for the PHY device.
>  	-phy-names:
>  		from general PHY binding: Should be "dp".
> -	-samsung,color-space:
> -		input video data format.
> -			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
> -	-samsung,dynamic-range:
> -		dynamic range for input video data.
> -			VESA = 0, CEA = 1
> -	-samsung,ycbcr-coeff:
> -		YCbCr co-efficients for input video.
> -			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
> -	-samsung,color-depth:
> -		number of bits per colour component.
> -			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> -	-samsung,link-rate:
> -		link rate supported by the panel.
> -			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
> -	-samsung,lane-count:
> -		number of lanes supported by the panel.
> -			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
> -	- display-timings: timings for the connected panel as described by
> -		Documentation/devicetree/bindings/video/display-timing.txt
											^^ display/display-timings.txt
otherwise this patch does not apply.
