From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Nov 2017 16:48:29 +0100
Subject: [PATCH] pinctrl: sunxi: Fix A80 interrupt pin bank
In-Reply-To: <20171125121948.24012-1-andre.przywara@arm.com>
References: <20171125121948.24012-1-andre.przywara@arm.com>
Message-ID: <CACRpkdaYpObvUdzXgVi84P_uQt8tWWEvYgovwN9jn07OFrVgMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 1:19 PM, Andre Przywara <andre.przywara@arm.com> wrote:

> On the A80 the pins on port B can trigger interrupts, and those are
> assigned to the second interrupt bank.
> Having two pins assigned to the same interrupt bank/pin combination does
> not look healthy (instead more like a copy&paste bug from pins PA14-PA16),
> so fix the interrupt bank for pins PB14-PB16, which is actually 1.
>
> I don't have any A80 board, so could not test this.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Patch applied with Chen-Yu's ACK and fixes tag.

Yours,
Linus Walleij
