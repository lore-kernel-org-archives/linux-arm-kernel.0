From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 3 Sep 2018 13:29:39 +0800
Subject: [PATCH] clk: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-12-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-12-robh@kernel.org>
Message-ID: <CAGb2v64axajQmvjt4Ht=3AG2Ybou_VP7v_m6mk4aa7CKyPDYbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>  drivers/clk/sunxi/clk-mod0.c        |  6 +++---
>  drivers/clk/sunxi/clk-sun9i-core.c  | 20 ++++++++++----------
>  drivers/clk/sunxi/clk-sunxi.c       |  4 ++--

For the sunxi bits,

Acked-by: Chen-Yu Tsai <wens@csie.org>
