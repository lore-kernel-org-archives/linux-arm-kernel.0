From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 11:55:40 -0600
Subject: [PATCH v9 10/14] ARM: tegra: Define Tegra114 CAR binding
In-Reply-To: <1365000110-8916-10-git-send-email-pdeschrijver@nvidia.com>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
 <1365000110-8916-10-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <515C6D1C.60503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 08:40 AM, Peter De Schrijver wrote:
> The device tree binding models Tegra114 CAR (Clock And Reset) as a single
> monolithic clock provider.

> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt

> +Mux clocks
> +
> +  300	audio0_mux
> +  301	audio1_mux
> +  302	audio2_mux
> +  303	audio3_mux
> +  304	audio4_mux
> +  305	spdif_mux
> +  306	clk_out_1_mux
> +  307	clk_out_2_mux
> +  308	clk_out_3_mux
> +  309	dsia_mux
> +  310	dsib_mux

I think Prashant was expecting those to be removed, and for this series
to rely on "clk: Add composite clock type" instead?
