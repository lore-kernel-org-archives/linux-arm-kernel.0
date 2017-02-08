From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 8 Feb 2017 11:40:36 -0800
Subject: [PATCH 09/22 v2] mtd: add DT bindings for the Cortina Systems
 Gemini Flash
In-Reply-To: <20170128215004.11532-1-linus.walleij@linaro.org>
References: <20170128215004.11532-1-linus.walleij@linaro.org>
Message-ID: <20170208194036.GC94627@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 10:50:04PM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Cortina systems Gemini
> flash controller, a simple physmap which however need a few
> syscon bits to be poked to operate properly.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add Marek's and Rob's ACK tags.
> 
> MTD maintainers: please just apply this to the MTD tree when
> you are happy with it. It is functionally orthogonal to the rest
> of the series and is just in the series for context.

I can't seem to find the rest of the series "for context", but this is
pretty harmless, so...

applied to l2-mtd.git.
