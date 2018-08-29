From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Aug 2018 10:50:38 +0200
Subject: [PATCH v2] pinctrl: uniphier: drop meaningless pin from SD1
 pin-mux of Pro4
In-Reply-To: <1533953773-29424-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533953773-29424-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZJHYda-TRJ9QB00Cs7Kna-Dq9Qhyugbv8wz0rxNwK2bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2018 at 4:16 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The pin 327 was supposed to be used as a voltage control line for the
> SD card regulator, but the SD card port1 does not support UHS-I.  It
> only supports 3.3V signaling, hence this pin is pointless.
>
> Just a note about the background.  At first, hardware engineers tried
> to implement the UHS for this port.  Then, they needed to shrink the
> silicon die size, and gave up the UHS, but forgot to remove the pin
> assignment.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
