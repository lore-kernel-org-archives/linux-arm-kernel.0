From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jul 2014 11:18:34 -0600
Subject: [PATCH 4/6] clk: tegra: add nvidia,tegra132-ccplex-clk binding
In-Reply-To: <1405437890-6468-5-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53CE9CEA.2060200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 09:24 AM, Peter De Schrijver wrote:
> Tegra132 has a few new clocks for the CPU complex (ccplex).

> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt

> +Example SoC include file:
> +
> +/ {
> +	ccplex-clock at 0,70040000 {
> +		compatible = "nvidia,tegra132-ccplex-clk";
> +		reg = <0x0 0x70040000 0x0 0x1000>;
> +		status = "okay";

That's the default, so it's not worth including that property.
