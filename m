From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Aug 2018 23:08:21 +0200
Subject: [PATCH] pinctrl: uniphier: drop meaningless pin from SD1 pin-mux
 of Pro4
In-Reply-To: <1533610179-13885-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533610179-13885-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYNEhq_3nO1OWokhuop83WAmURHmy0k=xyJRT32UFBSOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 4:50 AM Masahiro Yamada
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

This patch does not apply against my devel branch for v4.19.

Please rebase and resend.

Yours,
Linus Walleij
