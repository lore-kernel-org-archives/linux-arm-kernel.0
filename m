From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 21:08:17 +0200
Subject: [PATCH 1/2] clk: nomadik: implement the Nomadik clocks properly
In-Reply-To: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbtz=sJM+1ZEgLhfXT-or1a8AX6uwLWB1S8qS7b3N7fvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 12:55 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The Nomadik clock implementation was a stub just using
> fixed clocks.
>
> This implements the clocks properly instead of relying
> on them all being on at boot and leaving them all on.

Mike, ping on this.

There was some debate on whether to use 0 or 1 cells
for the clocks, but I made some argument that this is how
they need to be represented.

As subsystem maintainer I suspect you will need to be
the Judge (Dredd) on this. I think I overheard some kind
of positive tone to this style of modelling them  in some
other review but it might've been imagination ...

Yours,
Linus Walleij
