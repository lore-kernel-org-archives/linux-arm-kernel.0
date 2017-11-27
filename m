From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 27 Nov 2017 19:12:13 +0100
Subject: [PATCH v2 1/2] ARM: dts: exynos: Switch to dedicated Odroid-XU3
 sound card binding
In-Reply-To: <20171103165446.15438-2-s.nawrocki@samsung.com>
References: <20171103165446.15438-1-s.nawrocki@samsung.com>
 <CGME20171103165539epcas1p48cc87811574dace9dfe91d8e9ec6f7ca@epcas1p4.samsung.com>
 <20171103165446.15438-2-s.nawrocki@samsung.com>
Message-ID: <20171127181213.lxtbbiw75wbz2dbz@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 05:54:45PM +0100, Sylwester Nawrocki wrote:
> The new sound card DT binding is used for Odroid XU3 in order
> to properly support the HDMI audio path.
> Clocks configuration is changed so the I2S controller is now the bit
> and the frame clock master with EPLL as the root clock source.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi                    |  1 +
>  arch/arm/boot/dts/exynos5420.dtsi                 |  1 +
>  arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 60 ++++++++++++++---------
>  3 files changed, 40 insertions(+), 22 deletions(-)
> 

Thanks, applied both.

Best regards,
Krzysztof
