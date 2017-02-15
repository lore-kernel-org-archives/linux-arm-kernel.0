From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 16:51:25 -0600
Subject: [PATCH 12/22 v3] ARM: dts: add top-level DT bindings for Cortina
 Gemini
In-Reply-To: <20170207214812.27365-1-linus.walleij@linaro.org>
References: <20170207214812.27365-1-linus.walleij@linaro.org>
Message-ID: <20170215225125.buisugkh3qvkalzi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 10:48:12PM +0100, Linus Walleij wrote:
> This adds the top level SoC bindings for Cortina systems Gemini
> platforms.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Fix soc bus node and references.
> - Fix spelling of interrupt-controller
> ChangeLog v1->v2:
> - Rename required property "intcon" to "interrupt-controller"
> - Elaborate a bit on the SoC origins
> - Put the example DTS SoC nodes in a soc {} node
> ---
>  Documentation/devicetree/bindings/arm/gemini.txt | 84 ++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/gemini.txt

Acked-by: Rob Herring <robh@kernel.org> 

It is kind of strange to have an example for a board/soc. The dts itself 
provides that where as for a device, the exact binding may vary.

Rob
