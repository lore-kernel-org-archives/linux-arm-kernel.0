From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 13:07:22 +0100
Subject: [PATCH] pinctrl: mediatek: mt8135/mt8173: Fix build error due to
 missing include file
In-Reply-To: <1426143074.26140.0.camel@phoenix>
References: <1426143074.26140.0.camel@phoenix>
Message-ID: <CACRpkdbqh8XD2ci9VXChahWfhSr_uVAPLjGYrg9AAwDo-+zTRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 7:51 AM, Axel Lin <axel.lin@ingics.com> wrote:

> Fix below build error:
>   CC      drivers/pinctrl/mediatek/pinctrl-mt8135.o
> In file included from drivers/pinctrl/mediatek/pinctrl-mt8135.c:24:0:
> drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h:19:32: fatal error: pinctrl-mtk-common.h: No such file or directory
> compilation terminated.
> make[3]: *** [drivers/pinctrl/mediatek/pinctrl-mt8135.o] Error 1
> make[2]: *** [drivers/pinctrl/mediatek] Error 2
> make[1]: *** [drivers/pinctrl] Error 2
> make: *** [drivers] Error 2
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Patch applied. Partially, since Guenther already fixed one oneliner.

Yours,
Linus Walleij
