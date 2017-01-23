From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 14:01:47 -0600
Subject: [PATCH 02/22] irqchip: DT bindings for Cortina Gemini irqchip
In-Reply-To: <20170122121609.10098-1-linus.walleij@linaro.org>
References: <20170122121609.10098-1-linus.walleij@linaro.org>
Message-ID: <20170123200147.g72ws5fetcgxi3lu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 01:16:09PM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Cortina Gemini interrupt
> controller. They are pretty standard.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> irqchip maintainers: please just apply this when you feel pleased
> with it. These portions are functionally orthogonal to the series,
> it is just in a series for context.
> ---
>  .../cortina,gemini-interrupt-controller.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt

Acked-by: Rob Herring <robh@kernel.org>
