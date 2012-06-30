From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 30 Jun 2012 21:50:17 +0200
Subject: [PATCH] ARM: u300: convert to common clock
In-Reply-To: <1340142265-14549-1-git-send-email-linus.walleij@stericsson.com>
References: <1340142265-14549-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdakK9LPfZa8zWCE415GLc_n+tPqGJPQr6g1O2K0ptd-UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 11:44 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> This converts the U300 clock implementation over to use the common
> struct clk and moves the implementation down into drivers/clk.
> Since VCO isn't used in tree it was removed, it's not hard to
> put it back in if need be.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Mike if this looks allright, could you merge it into the clk-next branch?

Yours,
Linus Walleij
