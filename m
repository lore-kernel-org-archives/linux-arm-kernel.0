From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 14:02:45 -0600
Subject: [PATCH 04/22] clocksource: add DT bindings for Cortina Gemini
In-Reply-To: <20170122121707.10200-1-linus.walleij@linaro.org>
References: <20170122121707.10200-1-linus.walleij@linaro.org>
Message-ID: <20170123200245.4ophr2xm4vforxhn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 01:17:07PM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Cortina Systems Gemini
> timer block used in these SoCs.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> clocksource maintainers: please just apply this when you feel
> pleased with it. These portions are functionally orthogonal to
> the series, it is just in a series for context.
> ---
>  .../bindings/timer/cortina,gemini-timer.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/cortina,gemini-timer.txt

Acked-by: Rob Herring <robh@kernel.org>
