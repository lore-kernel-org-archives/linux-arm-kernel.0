From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 15:38:27 +0200
Subject: [PATCH] gpio: zynq: add missing module_exit function
In-Reply-To: <1434531101-2585-1-git-send-email-yamada.masahiro@socionext.com>
References: <1434531101-2585-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdahFxxBaFh593tH0gAY_u58R6055ubBjvmwtZufYOseDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 10:51 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This driver is tristate, so it should be cleanable.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied with Michal's test tag.

Yours,
Linus Walleij
