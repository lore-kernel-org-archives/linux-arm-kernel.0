From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 09:50:20 +0200
Subject: [PATCH v2 01/11] pinctrl: dt-bindings: add documentation for
 AP806 pin controllers
In-Reply-To: <2d89fbc10d07c890336eabbd362e55cb2e5055b5.1496413293.git-series.gregory.clement@free-electrons.com>
References: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
 <2d89fbc10d07c890336eabbd362e55cb2e5055b5.1496413293.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYw3AgKBa+y-U9=1d9HqYyPGYK1y_5eBYoobV6s=4T0Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 2, 2017 at 4:23 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> Document the device tree binding for the pin controllers found on the
> Armada 7K and Armada 8K SoCs.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

This patch does not apply to any of my branches, I have no clue
what tree you're basing this on.

I would prefer a series based on a pure v4.12-rc2 I think, as this
is what both the pin control and GPIO development branches
is based on, unless you have a better merge strategy to suggest?

I hope for the love of god that this does not also clash with the
PWM stuff that is patching around in the GPIO tree, if it does
I might very well throw up my hands and defer merging all of
this until the next kernel cycle past v4.13-rc1.

Please rebase on v4.12-rc2 and resend.

Yours,
Linus Walleij
