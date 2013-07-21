From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 21 Jul 2013 18:16:48 +0200
Subject: [PATCH 2/5] gpio: pxa: fix Documentation of interrupt-names
 property
In-Reply-To: <1373555877-29887-3-git-send-email-zonque@gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
 <1373555877-29887-3-git-send-email-zonque@gmail.com>
Message-ID: <CACRpkdazAgZO4610Oppk12MCgErsKmEXcjnnkzsH4JMOBWB8Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 5:17 PM, Daniel Mack <zonque@gmail.com> wrote:

> The property name to pass names for interrupt resources is called
> "interrupt-names", not "interrupt-name". Fix it to avoid further
> confusion.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Obviously correct so applied.

Cc binding patches to devicetree at vger.kernel.org going
forward...

Yours,
Linus Walleij
