From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 11:11:48 -0600
Subject: [PATCH 1/4] power: reset: Add Gemini poweroff DT bindings
In-Reply-To: <20170130193635.18644-1-linus.walleij@linaro.org>
References: <20170130193635.18644-1-linus.walleij@linaro.org>
Message-ID: <20170201171148.zp2aol4abushh335@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 08:36:32PM +0100, Linus Walleij wrote:
> This adds device tree bindings to the power management controller
> in the Gemini SoC.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Sebastian: please just merge this when your are pleased
> with it. I will funnel the ARM parts through the ARM SoC tree.
> ---
>  .../devicetree/bindings/power/reset/gemini-poweroff.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt

Acked-by: Rob Herring <robh@kernel.org>
