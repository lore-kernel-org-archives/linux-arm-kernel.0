From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Dec 2012 11:21:11 +0100
Subject: [PATCH 1/1 v2] gpio: Provide the STMPE GPIO driver with its own
 IRQ Domain
In-Reply-To: <20121210100754.GB9362@gmail.com>
References: <1353683949-9275-1-git-send-email-lee.jones@linaro.org>
 <20121210100754.GB9362@gmail.com>
Message-ID: <CACRpkdYe1YbeyxC0OWqAY_MFq6oXVLzr0+s50O7X0LZducL4rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 11:07 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Fri Nov 23 12:36:23 2012 +0000
>
>     gpio: Provide the STMPE GPIO driver with its own IRQ Domain
>
>     The STMPE GPIO driver can be used as an IRQ controller by some

What is this funny citing and indentation business here... I stripped
all the whitespace by hand, no big deal, just curious.

Looks like you e.g. copy/pasted from a "git log" command log rather
than from an actual patch.

>     related devices. Here we provide it with its very own IRQ Domain
>     so that IRQs can be issued dynamically. This will stand the
>     driver in good stead when it is enabled for Device Tree, as this
>     it a prerequisite.
>
>     Cc: Grant Likely <grant.likely@secretlab.ca>
>     Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.

I apply this late because not using an irqdomain when we can is
an abomination so I'm taking the risk.

Yours,
Linus Walleij
