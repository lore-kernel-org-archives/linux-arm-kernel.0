From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 10 Apr 2017 15:42:05 +0900
Subject: [PATCH] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
References: <CGME20170410051733epcas1p1b54d228cf6a72062daf2f061d7b880f7@epcas1p1.samsung.com>
 <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
Message-ID: <58EB293D.7060603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017? 04? 10? 14:16, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
>  Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
>  arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
>  arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
>  arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
>  arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
>  arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
>  arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
>  arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
>  arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  8 +--
>  arch/arm/boot/dts/uniphier-pro5.dtsi               | 32 +++++------
>  arch/arm/boot/dts/uniphier-pxs2.dtsi               | 16 +++---
>  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 14 ++---
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 32 +++++------
>  arch/arm64/boot/dts/zte/zx296718.dtsi              | 10 ++--
>  18 files changed, 280 insertions(+), 280 deletions(-)
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
