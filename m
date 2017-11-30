From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Nov 2017 15:38:06 +0100
Subject: [PATCH] gpio: uniphier: fix mismatch between license text and
 MODULE_LICENSE
In-Reply-To: <1511431310-9892-1-git-send-email-yamada.masahiro@socionext.com>
References: <1511431310-9892-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYQZDyFKmg1Ber1fNR+XCN05v1UNZdEYyWc3wUgC3J22w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 11:01 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The comment block of this file indicates GPL-2.0 "only", while the
> MODULE_LICENSE is GPL-2.0 "or later", as include/linux/module.h
> describes as follows:
>
>   "GPL"                           [GNU Public License v2 or later]
>   "GPL v2"                        [GNU Public License v2]
>
> I am the author of this driver, and my intention is GPL-2.0 "only".
>
> Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
