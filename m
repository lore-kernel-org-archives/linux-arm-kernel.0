From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 18 Jun 2018 14:51:16 +0530
Subject: [PATCH] ARM: dts: rockchip: convert rk3288 to operating-points-v2
In-Reply-To: <20180617131808.30283-1-heiko@sntech.de>
References: <20180617131808.30283-1-heiko@sntech.de>
Message-ID: <20180618092116.gbxlb46cqihtlhwa@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-06-18, 15:18, Heiko Stuebner wrote:
> +	cpu_opp_table: cpu-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {

Most of the platforms write it as "opp-126000000". Maybe follow the same
nomenclature ?
-- 
viresh
