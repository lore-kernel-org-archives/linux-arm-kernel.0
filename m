From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 18:00:47 +0200
Subject: [PATCH v2] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <20180928114250.7858-1-linus.walleij@linaro.org>
References: <20180928114250.7858-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a2vdYfo6=h0nmA86Kb4m+KVtP3hQ_k8_DZd67182Qh0pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 1:43 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> With this I assume maintainership of the Integrator, Versatile
> and RealView ARM reference machines.
>
> It's no big secret that I've been maintaining them for years,
> but might as well make it official so I get the mails and
> don't miss anything.
>
> I have also included some drivers that are closely associated
> with the ARM reference designs and yet orphaned in the
> MAINTAINERS file. I can surely maintain them too, or route
> the question to the right people so it doesn't fall on the
> floor of upward to the subsystem maintainers who have too much
> to do already as it is.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Michael Turquette <mturquette@baylibre.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Split out PL022 and PL190/PL192 drivers to their own
>   MAINTAINERS entries.
>
> ARM SoC folks: please apply this directly wherever MAINTAINERS
> patches go.

Applied, thanks!

      Arnd
