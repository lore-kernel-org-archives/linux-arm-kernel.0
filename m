From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Oct 2016 16:55:48 +0530
Subject: [PATCH 2/3] arm64: dts: uniphier: add CPU clock and OPP table
 for LD11 SoC
In-Reply-To: <1476629958-25368-3-git-send-email-yamada.masahiro@socionext.com>
References: <1476629958-25368-1-git-send-email-yamada.masahiro@socionext.com>
 <1476629958-25368-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161018112548.GA11471@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-10-16, 23:59, Masahiro Yamada wrote:
> +	cluster0_opp: opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp at 245000000 {
> +			opp-hz = /bits/ 64 <245000000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp at 250000000 {
> +			opp-hz = /bits/ 64 <250000000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp at 490000000 {
> +			opp-hz = /bits/ 64 <490000000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp at 500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp at 653333333 {

Why isn't ^^ matching with below values ? Same in next patch as well.

> +			opp-hz = /bits/ 64 <653334000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp at 666666666 {
> +			opp-hz = /bits/ 64 <666667000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp at 980000000 {
> +			opp-hz = /bits/ 64 <980000000>;
> +			clock-latency-ns = <300>;
> +		};
> +	};
> +
>  	clocks {
>  		refclk: ref {
>  			compatible = "fixed-clock";
> -- 
> 1.9.1

-- 
viresh
