From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Aug 2017 00:06:15 +0200
Subject: [GIT PULL] Reset controller changes for v4.14
In-Reply-To: <1503051046.7730.7.camel@pengutronix.de>
References: <1503051046.7730.7.camel@pengutronix.de>
Message-ID: <CAK8P3a1eOMim4tP2OFLrEDf+1-L4gy0W5hjbfzT1SAqX5DxrtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 12:10 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Dear arm-soc maintainers,
>
> please consider merging this tag for v4.14. It contains a new HSDKv1
> reset driver, updates and fixes for the uniphier driver, a reset array
> API to handle a number of resets together, and removes the Gemini reset
> driver, which is replaced by a combined clock/reset driver in
> drivers/clk.

Pulled into next/drivers, thanks!

      Arnd
