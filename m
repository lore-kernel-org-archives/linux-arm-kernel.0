From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 10:15:37 +0100
Subject: [PATCH] pinctrl: uniphier: remove eMMC hardware reset pin-mux
In-Reply-To: <1508818271-6298-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508818271-6298-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYRg-mkqZ7_bCt6aKkd=vBm2sCeu_xhJ15KdsaLvgOAwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 6:11 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This is handled by the mmc-pwrseq-emmc driver, which controls
> an eMMC hardware reset via a GPIO line.
>
> Remove it from the function pin-mux settings.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
