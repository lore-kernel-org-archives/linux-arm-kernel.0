From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Nov 2012 20:04:23 +0100
Subject: [PATCH] clk: ux500: assume PRCC clocks are off by default
In-Reply-To: <1354024310-22021-1-git-send-email-linus.walleij@stericsson.com>
References: <1354024310-22021-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdYFR4Ci6QcLmgeEQOOqJ1N5sYpoPE5ivj2gV9t=-BqTOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 2:51 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The code for the PRCC clock assumed that on boot all the PRCC
> clocks were on, defining them as enabled. However some such
> clocks like the clock for the GPIO block 6 in the PER2
> peripheral group are not on at all.

Bah, the problem I'm describing is probably true, but I was
mistaken (of course). I have a more ACK:able patch now...

Forget about this patch, check the next one.

Yours,
Linus Walleij
