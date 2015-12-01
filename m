From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 10:36:49 +0100
Subject: [PATCH] pinctrl: uniphier: rework UniPhier pinctrl entries in
 Kconfig
In-Reply-To: <1448344846-28726-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448344846-28726-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdaeGjidAQNKWN6MOLUE=EO4WJ6VGQo7SrkZtcoNeDaFiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 7:00 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> There is a plan to support more pinctrl drivers for this SoC family.
> Move the driver entries into a sub menu by using "menuconfig".
> Also, add the missing dependency "depends on OF && MFD_SYSCON".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
