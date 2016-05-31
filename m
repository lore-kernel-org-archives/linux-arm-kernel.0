From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 12:40:11 +0200
Subject: [PATCH 05/17] pinctrl: uniphier: set pinctrl_desc name in common
 probe function
In-Reply-To: <1464681923-7469-6-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
 <1464681923-7469-6-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYNrKSULcoos3owH76+Bx0Kgi3mFh1YrESFZZhrwWF+wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 10:05 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Every SoC driver sets the same name for struct pinctrl_desc and
> platform_driver.  The common probe function can set desc->name
> instead of duplicating strings in each SoC driver.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
