From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Nov 2016 10:30:46 +0100
Subject: [RFC PATCH] mfd: dt: Add Aspeed LPC binding
In-Reply-To: <20161117060633.3837-1-andrew@aj.id.au>
References: <20161117060633.3837-1-andrew@aj.id.au>
Message-ID: <CACRpkdazPEbU2gmDyke=GTYtjVp8aeauS+PVkp-zuiVoVz7kbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 7:06 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> +* Device tree bindings for the Aspeed LPC Controller

We are going overboard with the lingo sometimes, to the point that we do not
understand how terse things become.

LPC = Low Pin Count, right?
Explain that right here: it is a slow external bus, right?

> +The Aspeed LPC controller contains registers for a variety of functions. Not
> +all registers for a function are contiguous, and some registers are referenced
> +by functions outside the LPC controller.
> +
> +Note that this is separate from the H8S/2168 compatible register set occupying
> +the start of the LPC controller address space.
> +
> +Some significant functions in the LPC controller:
> +
> +* LPC Host Controller
> +* Host Interface Controller

Host interface to what?

> +* iBT Controller

What is iBT?

> +* SuperIO Scratch registers

Again more context please.

With standards documents, either explain everything or provide
pointers for the information.

Yours,
Linus Walleij
