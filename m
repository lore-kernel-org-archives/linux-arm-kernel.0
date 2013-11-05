From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Nov 2013 13:33:22 +0100
Subject: [PATCH 1/4] ARM/serial: at91: move machine quirk into machine
In-Reply-To: <5278D20C.50906@atmel.com>
References: <1383643722-14189-1-git-send-email-linus.walleij@linaro.org>
 <5278D20C.50906@atmel.com>
Message-ID: <CACRpkdbDksG=BW_udAV9vt7nP-Yqj1k9fkz9-5WS4qdeiWYy+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 12:10 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 05/11/2013 10:28, Linus Walleij :

> I do think that we have to remove this dependency but the only thing that
> embarrasses me is that your change only allows non-DT at91rm9200 to work
> well with its RTS line.
> If we use Device Tree with this product (which is actually possible) we
> don't have this feature available anymore...

You can still supply the callback into the machine using
AUXDATA if you wish.

But I can do the thing mentioned in the commit message and
switch the driver to use gpiolib instead, I'll send another patch,
can you please test it...

Yours,
Linus Walleij
