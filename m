From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Jun 2017 17:27:47 -0700
Subject: [PATCH] ARM: dts: augment Moxa and Aspeed DTS for FTTMR010
In-Reply-To: <20170524090748.27345-1-linus.walleij@linaro.org>
References: <20170524090748.27345-1-linus.walleij@linaro.org>
Message-ID: <20170602002747.GN13314@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 11:07:48AM +0200, Linus Walleij wrote:
> This augments the Moxa Art and Aspeed device trees to:
> 
> - Explicitly name the clock "PCLK" as the Faraday FTTMR010
>   names it.
> - List the Moxa timer as compatible with the Faradat FTTMR010
>   vanilla version.
> - Add a comment that the Aspeed driver is a Faraday
>   FTTMR010 derivative.
> - Pass all IRQs to the timer from Aspeed: they are all there
>   so they should be in the device tree, we only use the
>   first one anyways.
> 
> Tested-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC maintainers: this is the DTS changes needt to generalize
> the Faraday timer. Please merge this into some suitable ARM SoC
> DTS branch.
> Clocksource maintainers: I will ask the ARM SoC people to merge
> this patch orthogonally, it is only included in this series
> for reference and for testing.

Merged into next/dt for v4.13. Thanks!


-Olof
