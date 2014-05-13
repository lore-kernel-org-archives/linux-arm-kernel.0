From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 May 2014 16:47:15 +0200
Subject: [PATCH 2/8] clk: berlin: add clock binding docs for Marvell
 Berlin2 SoCs
In-Reply-To: <1399839881-29895-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1399839881-29895-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140513144715.GF29318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Not much to say,

On 11/05/2014 at 22:24:35 +0200, Sebastian Hesselbarth wrote :
> +* Single-register clock dividers
> +
> +Single-register clock dividers are complex divider cells, allowing
> +to divide a reference clock with a set of fixed dividers. Also they
> +comprise and input clock mux with bypass and an ouput clock gate.
typo here-----^

> +
> +Required properties:
> +- compatible: shall be "marvell,berlin2-clk-div"
> +- reg: address and length of the corresponding DIV registers
> +- #clock-cells: shall be set to 0
> +- clocks: clock specifiers referencing the DIV input clocks
> +- clock-names: array of strings describing the clock specifiers above.
> +    Allowed clock-names are "mux_bypass" for the clock mux bypass selection
> +    and "muxN" (N=0..7) for each of the 8 possible clock mux inputs.
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
