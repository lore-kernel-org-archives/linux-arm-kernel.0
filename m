From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 24 Nov 2015 00:04 +0100
Subject: [PATCH V3 5/5] ARM: dts: exynos4412: Rename OPP nodes as
 opp@<opp-hz>
In-Reply-To: <af18ab62fc9c52e082380ce5989ea287304c9bde.1447209519.git.viresh.kumar@linaro.org>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
 <af18ab62fc9c52e082380ce5989ea287304c9bde.1447209519.git.viresh.kumar@linaro.org>
Message-ID: <2407684.GgMbGa6LFq@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 11, 2015 08:10:58 AM Viresh Kumar wrote:
> OPP bindings got updated to name OPP nodes this way, make changes
> according to that.
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 294cfe40388d..40beede46e55 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -64,73 +64,73 @@
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> -		opp00 {
> +		opp at 200000000 {
>  			opp-hz = /bits/ 64 <200000000>;
>  			opp-microvolt = <900000>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp01 {
> +		opp at 300000000 {
>  			opp-hz = /bits/ 64 <300000000>;
>  			opp-microvolt = <900000>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp02 {
> +		opp at 400000000 {
>  			opp-hz = /bits/ 64 <400000000>;
>  			opp-microvolt = <925000>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp03 {
> +		opp at 500000000 {
>  			opp-hz = /bits/ 64 <500000000>;
>  			opp-microvolt = <950000>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp04 {
> +		opp at 600000000 {
>  			opp-hz = /bits/ 64 <600000000>;
>  			opp-microvolt = <975000>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp05 {
> +		opp at 700000000 {
>  			opp-hz = /bits/ 64 <700000000>;
>  			opp-microvolt = <987500>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp06 {
> +		opp at 800000000 {
>  			opp-hz = /bits/ 64 <800000000>;
>  			opp-microvolt = <1000000>;
>  			clock-latency-ns = <200000>;
>  			opp-suspend;
>  		};
> -		opp07 {
> +		opp at 900000000 {
>  			opp-hz = /bits/ 64 <900000000>;
>  			opp-microvolt = <1037500>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp08 {
> +		opp at 1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <1087500>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp09 {
> +		opp at 1100000000 {
>  			opp-hz = /bits/ 64 <1100000000>;
>  			opp-microvolt = <1137500>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp10 {
> +		opp at 1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <1187500>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp11 {
> +		opp at 1300000000 {
>  			opp-hz = /bits/ 64 <1300000000>;
>  			opp-microvolt = <1250000>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp12 {
> +		opp at 1400000000 {
>  			opp-hz = /bits/ 64 <1400000000>;
>  			opp-microvolt = <1287500>;
>  			clock-latency-ns = <200000>;
>  		};
> -		opp13 {
> +		opp at 1500000000 {
>  			opp-hz = /bits/ 64 <1500000000>;
>  			opp-microvolt = <1350000>;
>  			clock-latency-ns = <200000>;
> 

This one doesn't apply for me on top of the current Linus' tree, so please
update.

Thanks,
Rafael
