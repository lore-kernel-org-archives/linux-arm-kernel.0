From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 Mar 2018 12:39:43 +0100
Subject: [PATCH 4/4] ARM: dts: Enable HDMI audio on Snow Chromebook
In-Reply-To: <20180307172711.15697-4-s.nawrocki@samsung.com>
References: <20180307172711.15697-1-s.nawrocki@samsung.com>
 <CGME20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420@epcas2p2.samsung.com>
 <20180307172711.15697-4-s.nawrocki@samsung.com>
Message-ID: <00f84b39-3272-72ca-5991-bc0f839a0324@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2018 06:27 PM, Sylwester Nawrocki wrote:
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -18,6 +18,14 @@

> +		cpu {
> +			sound-dai = <&i2s0 0>;
> +		};
> +
> +		codec {
> +			sound-dai = <&hdmi>, <&max98095 0>;

Oops, I need to change order of codecs on the list, so it matches
documentation. Will post v2 shortly.

-- 
Thanks,
Sylwester
