From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 14:13:47 -0600
Subject: [PATCH 09/22] mtd: add DT bindings for the Cortina Systems
 Gemini Flash
In-Reply-To: <20170122122119.10510-1-linus.walleij@linaro.org>
References: <20170122122119.10510-1-linus.walleij@linaro.org>
Message-ID: <20170123201347.zjarugehax7zovig@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 01:21:19PM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Cortina systems Gemini
> flash controller, a simple physmap which however need a few
> syscon bits to be poked to operate properly.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> MTD maintainers: please just apply this to the MTD tree when
> you are happy with it. It is functionally orthogonal to the rest
> of the series and is just in the series for context.
> ---
>  .../bindings/mtd/cortina,gemini-flash.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt

Acked-by: Rob Herring <robh@kernel.org>
