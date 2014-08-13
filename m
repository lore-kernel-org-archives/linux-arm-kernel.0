From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Aug 2014 11:14:33 +0200
Subject: [PATCH 1/6] leds: add a driver for syscon-based LEDs
In-Reply-To: <1406294628-16079-2-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <1406294628-16079-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdb5p5EO2G7TMQMdiugWN_oLC6fODKk-jG-VcTdcWHfqRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 3:23 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This makes it possible to create a set of LEDs from a syscon
> MFD instance, which is lean mean and clean on the ARM
> reference designs and can replace the Versatile LEDs driver
> in the long run, as well as other custom syscon LEDs drivers.
>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Bryan can you have a look at this driver? It can be merged
stand-alone through the LEDs tree for v3.18 once you're
happy with it.

Yours,
Linus Walleij
