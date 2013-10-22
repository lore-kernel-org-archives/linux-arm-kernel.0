From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Oct 2013 18:57:29 +0200
Subject: [PATCH 1/2] leds: lp55xx: handle enable pin in driver
In-Reply-To: <1382446896-28436-2-git-send-email-sre@debian.org>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
 <1382446896-28436-2-git-send-email-sre@debian.org>
Message-ID: <CACRpkdZzoQ4auk1Q1wB=H-i4Aw7tPaHf3J8Dsa3vA_0Wx65qtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 3:01 PM, Sebastian Reichel <sre@debian.org> wrote:

> This patch moves the handling of the chip's enable pin from the board
> code into the driver. It also updates all board-code files using the
> driver to incorporate this change.
>
> This is needed for device tree support of the enable pin.
>
> Signed-off-by: Sebastian Reichel <sre@debian.org>

Looks good to me.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

BTW: should we disable the GPIO when remove()ing the module?
This is a topic of another patch but...

Yours,
Linus Walleij
