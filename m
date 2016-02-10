From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 15:36:03 +0100
Subject: [PATCH 1/8] clk: add device tree binding for artpec-6 pll1 clock
In-Reply-To: <c092f501a595032f9b76f18fc4bf093503a181c8.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
 <c092f501a595032f9b76f18fc4bf093503a181c8.1455107681.git.larper@axis.com>
Message-ID: <12746231.crYxCXlbXY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 February 2016 13:41:50 Lars Persson wrote:
> Signed-off-by: Lars Persson <larper@axis.com>
> ---

Always write a changelog comment.

> +* Clock bindings for Axis ARTPEC-6 chip
> +
> +Required properties:
> +- compatible: Should be "axis,artpec6-pll1-clock"
> +- #clock-cells: Should be <1>

What is the clock cell used for?

> +Examples:
> +
> +pll1_clk: pll1_clk {
> +	#clock-cells = <1>;
> +	compatible = "axis,artpec6-pll1-clock";
> +	clocks = <&ext_clk>;
> +	status = "okay";
> +};
> 
