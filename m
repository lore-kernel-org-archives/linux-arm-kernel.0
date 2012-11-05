From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Nov 2012 12:40:20 +0100
Subject: [PATCH 0/2] clk: ux500: Add some more clk lookups for u8500
In-Reply-To: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZjLac9+dRwUm=ka7ZCouAx0bztNjEcjsPdsjZ=Ckz5rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 2:40 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Some more clock lookups added for rng clocks and for the nomadik ske
> keypad clocks.
>
> Ulf Hansson (2):
>   clk: ux500: Register rng clock lookups for u8500
>   clk: ux500: Register nomadik keypad clock lookups for u8500

Acked-by: Linus Walleij <linus.walleij@linaro.org>

for these.

They have the right name and all, apb_pclk is
"AMBA peripheral bus, peripheral block clock"
so a clock for the silicon, right.

... then how it's supposed to be used, that's another
issue...

Yours,
Linus Walleij
