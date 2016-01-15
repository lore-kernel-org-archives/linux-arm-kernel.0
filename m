From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 21:02:16 -0600
Subject: [PATCH v2 06/26] clk: sunxi: Add PLL3 clock
In-Reply-To: <1452785109-6172-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160115030216.GA18411@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 04:24:49PM +0100, Maxime Ripard wrote:
> The A10 SoCs and relatives have a PLL controller to drive the PLL3 and
> PLL7, clocked from a 3MHz oscillator, that drives the display related
> clocks (GPU, display engine, TCON, etc.)
> 
> Add a driver for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/Makefile                        |  1 +
>  drivers/clk/sunxi/clk-sun4i-pll3.c                | 90 +++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-pll3.c
