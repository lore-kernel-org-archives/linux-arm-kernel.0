From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Jul 2016 11:48:22 +0200
Subject: [PATCH] pinctrl: uniphier: remove pointless pin-mux settings for
 PH1-LD11
In-Reply-To: <1467190633-19990-1-git-send-email-yamada.masahiro@socionext.com>
References: <1467190633-19990-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYzOwSKFdcVEc2wbFxAec_pHgR_CKvRUHbLN7Pu-mRWKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 10:57 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This SoC has no SD card controller.  Nor does it have USB port3.
> These pin-mux settings have no point.
>
> Fixes: 70f2f9c4cf25 ("pinctrl: uniphier: add UniPhier PH1-LD11 pinctrl driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
