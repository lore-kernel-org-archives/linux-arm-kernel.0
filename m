From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 16:32:23 -0600
Subject: [PATCH] pinctrl: gemini: Support drive strength setting
In-Reply-To: <20171202112309.5726-1-linus.walleij@linaro.org>
References: <20171202112309.5726-1-linus.walleij@linaro.org>
Message-ID: <20171204223223.vafeozlsr2obezuh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 02, 2017 at 12:23:09PM +0100, Linus Walleij wrote:
> The Gemini pin controller can set drive strength for a few
> select groups of pins (not individually). Implement this
> for GMAC0 and 1 (ethernet ports), IDE and PCI.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> The DT binding part is just using generic bindings, so should be
> pretty uncontroversial.
> ---
>  .../bindings/pinctrl/cortina,gemini-pinctrl.txt    |  3 +
>  drivers/pinctrl/pinctrl-gemini.c                   | 81 ++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
