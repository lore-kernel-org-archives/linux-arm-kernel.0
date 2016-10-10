From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2016 09:59:57 +0200
Subject: [PATCH 0/8] pinctrl: aspeed: Fixes for core and g5, implement
 remaining pins
In-Reply-To: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
Message-ID: <CACRpkdZWbx1_SYJMOn40teQaEw1JAq80kDAp7N+OYaMRRO6NBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2016 at 4:50 PM, Andrew Jeffery <andrew@aj.id.au> wrote:

> The initial Aspeed pinctrl patches implemented a subset of pins for each of the
> g4 and g5 SoCs. This series provides a number of fixes to the initial patches,
> mostly for issues identified in the g5 driver. The fixes account for the first
> half of the series (up to and including "pinctrl: aspeed-g5: Fix pin
> association of SPI1 function") and should be applied for 4.9.

Those are applied for fixes.

> The second half, from "pinctrl: aspeed: Enable capture of off-SCU pinmux
> state", implements some additional functionality in the core engine for the
> Aspeed SoCs and follows up with patches implementing mux configuration tables
> for all remaining pins. Given the significant additions in the last few
> patches, their lateness in the cycle and the light testing they have received
> they are best left for 4.10, but I'm keen to get them out for review.

I'm holding these back until v4.9-rc1 is out.

Yours,
Linus Walleij
