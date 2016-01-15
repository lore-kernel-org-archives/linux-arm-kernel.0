From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 21:01:33 -0600
Subject: [PATCH v2 05/26] clk: sunxi: Add display and TCON0 clocks driver
In-Reply-To: <1452785109-6172-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160115030133.GA17174@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 04:24:48PM +0100, Maxime Ripard wrote:
> The A10 SoCs and its relatives has a special clock controller to drive the
> display engines (both frontend and backend), that have a lot in common with
> the clock to drive the first TCON channel.
> 
> Add a driver to support both.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +

Can't someone read the datasheet and add these compatible strings in one 
pass instead of one at a time?

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-sun4i-display.c             | 241 ++++++++++++++++++++++
>  3 files changed, 244 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-display.c
