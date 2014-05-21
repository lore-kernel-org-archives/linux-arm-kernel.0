From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 May 2014 00:52:13 +0200
Subject: [PATCH] clk: impd1: add pclk clocks
In-Reply-To: <1397550585-7248-1-git-send-email-linus.walleij@linaro.org>
References: <1397550585-7248-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZi9ippzqqsHzJ0K=m=z0T6_FdkLuES7ZhrKn-spdrJeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 10:29 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> The IM-PD1 PrimeCells all have pclk assignments though this clock
> cannot be controlled, and we need to provide this as a dummy
> clock for the PL061 GPIO driver to probe, so let's assign it to
> all the cells on the board.
>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Mike, ping are you taking this patch to the clk tree?

Yours,
Linus Walleij
