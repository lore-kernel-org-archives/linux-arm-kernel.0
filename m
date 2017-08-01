From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 10:15:42 +0200
Subject: [PATCH 4/6] pinctrl: uniphier: omit redundant input enable bit
 information
In-Reply-To: <1501482071-9819-5-git-send-email-yamada.masahiro@socionext.com>
References: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
 <1501482071-9819-5-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYpLYcKCbvpMQ34iLsdjroGKy=UvFqG3nqQk5VyA8CB0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 8:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> For LD11/20 SoCs (capable of per-pin input enable), the iectrl bit
> number matches its pin number.  So, this is redundant information.
> Instead, we just need a flag to know if the iectrl gating exists or not.
>
> With this refactoring, 5 bits in pin data will be saved.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
