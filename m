From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 17:03:37 +0200
Subject: [GIT PULL] Reset controller changes for v4.17, part 2
In-Reply-To: <1522166897.3345.16.camel@pengutronix.de>
References: <1522166897.3345.16.camel@pengutronix.de>
Message-ID: <CAK8P3a0n98Yg+G+VFVBnHDHAoaNcTxdQinJjBjgyC82Ac=7LHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 6:08 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Dear arm-soc maintainers,
>
> The following changes since commit 1d7592f84f92c6344978186fdbe547af044274b5:
>
>   reset: simple: Enable for ASPEED systems (2018-02-20 17:42:29 +0100)
>
> are available in the Git repository at:
>
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.17-2
>
> for you to fetch changes up to 0089313d8595b76422b189b44c55556cb1004190:
>
>   Merge branch 'reset/lookup' into reset/next (2018-03-27 11:03:43 +0200)
>
> ----------------------------------------------------------------
> Reset controller changes for v4.17, part 2
>
> This tag contains reset lookup support, similar to pwm lookups, for legacy
> non-DT platforms, a few new reset controls and a Kconfig fix for uniphier
> SoCs, as well as a new driver for the STM32MP1 peripheral reset controller.
>
> The reset lookups are merged from a separate, immutable branch, that may
> also be merged into the davinci tree.
>

Pulled into next/drivers, thanks!

     Arnd
