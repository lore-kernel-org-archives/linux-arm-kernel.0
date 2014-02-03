From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Feb 2014 10:23:57 +0100
Subject: [PATCH 4/5] clk: versatile: pass a parent to the ICST clock
In-Reply-To: <1390251324-6369-1-git-send-email-linus.walleij@linaro.org>
References: <1390251324-6369-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZ7Kx3mp63k=QACtB6aafL-qFj5KHQ0CWKWG8cN_EA8qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 9:55 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> As we want to actually define the parent frequency in the device
> tree for the ICST clocks, modify the clock registration function
> to take a parent argument.
>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Mike, looking for an ACK to take this through the Integrator
> and ARM SOC tree.

Hi Mike,

Ping on this!

Yours,
Linus Walleij
