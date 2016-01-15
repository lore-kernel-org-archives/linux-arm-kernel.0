From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 21:03:04 -0600
Subject: [PATCH v2 07/26] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <1452785109-6172-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160115030304.GA18853@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 04:24:50PM +0100, Maxime Ripard wrote:
> The TCON is a controller generating the timings to output videos signals,
> acting like both a CRTC and an encoder.
> 
> It has two channels depending on the output, each channel being driven by
> its own clock (and own clock controller).
> 
> Add a driver for the channel 1 clock.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-sun4i-tcon-ch1.c            | 154 ++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
