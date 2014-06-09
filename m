From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jun 2014 14:14:20 +0200
Subject: [RESEND: PATCH 1/2] mfd: tc3589x: Add device tree bindings
In-Reply-To: <1397028480-15413-1-git-send-email-linus.walleij@linaro.org>
References: <1397028480-15413-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbhqoywNyHuXzo2Oqjz5ybcM_DhsRDYy28_qN8K0RYE_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 9:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This defines the device tree bindings for the Toshiba TC3589x
> series of multi-purpose expanders. Only the stuff I can test
> is defined: GPIO and keypad. Others may implement more
> subdevices further down the road.
>
> This is to complement
> commit a435ae1d51e2f18414f2a87219fdbe068231e692
> "mfd: Enable the tc3589x for Device Tree" which left off
> the definition of the device tree bindings.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Fix the keys/rows bindings to be u32 rather than
>   /bits/ 8, inconsistency noted by Mark Rutland.
> ChangeLog v1->v2:
> - Include a verbose example in the DT bindings.
> - Explain why this is a stand-alone bindings patch.

Lee, ping on this - it seems to have fallen to the floor at some
point...

Yours,
Linus Walleij
