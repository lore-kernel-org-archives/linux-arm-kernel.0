From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 09:20:15 +0200
Subject: [PATCH v2 1/7] pinctrl: UniPhier: add UniPhier pinctrl core
 support
In-Reply-To: <1436841607-7556-2-git-send-email-yamada.masahiro@socionext.com>
References: <1436841607-7556-1-git-send-email-yamada.masahiro@socionext.com>
 <1436841607-7556-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZFfypZfDAmULcC1_q_bYD-nsh2H0rMAqo+ncWsBx6m=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 4:40 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The core support for the pinctrl drivers for all the UniPhier SoCs.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - drop vogus THIS_MODULE because this file is always built-in
>   - drop vogus "include <linux/module.h> because this file is
>     always built-in

This looks nice and uses all generic facilities we have.

Patch applied.

Yours,
Linus Walleij
