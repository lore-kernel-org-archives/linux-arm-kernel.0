From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Jun 2016 10:02:38 +0200
Subject: [PATCH 1/2] pinctrl: uniphier: prohibit drive control for pin
 61-66 of PH1-LD11
In-Reply-To: <1465978686-28578-2-git-send-email-yamada.masahiro@socionext.com>
References: <1465978686-28578-1-git-send-email-yamada.masahiro@socionext.com>
 <1465978686-28578-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYjGXN1753bbHx-sQfekzUQWg+QSORTMNg4yrSyjFfnqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 10:18 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> According to the hardware document, setting the drive control is
> prohibited for these pins (N-channel Open Drain pins).  Set their
> drive control attribute to "fixed".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
