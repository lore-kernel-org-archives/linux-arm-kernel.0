From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 12:15:24 +0100
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
In-Reply-To: <201301101008.45091.arnd@arndb.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301091046.13020.arnd@arndb.de> <2270940.DTxEYMZtED@percival>
 <201301101008.45091.arnd@arndb.de>
Message-ID: <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I've tried to find platforms that don't yet use GPIOLIB and fortunately
> there are very few left:
>
> I found two that provide the generic gpio interfaces when gpiolib
> is disabled, but use gpiolib otherwise for the same hardware,
> arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
> I would assume that we can simply remove the non-gpiolib shortcut
> here at cost of a small overhead.

Geert/Greg: interested in looking into this issue?

The GPIO maintainers want to get rid of non-gpiolib platforms.

Yours,
Linus Walleij
