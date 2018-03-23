From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Mar 2018 04:05:23 +0100
Subject: [PATCH] pinctrl: stm32: add 'depends on HAS_IOMEM' to fix unmet
 dependency
In-Reply-To: <1520334956-9900-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520334956-9900-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYZCxX+=1-Ght1gJoyLFXk_W+3hpAn5XEWm13OnGQiCEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2018 at 12:15 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> These configs select MFD_SYSCON, but do not depend on HAS_IOMEM.
>
> Compile testing on architecture without HAS_IOMEM causes "unmet
> direct dependencies" in Kconfig phase.
>
> Detected by "make ARCH=score allyesconfig".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
