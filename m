From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 10:59:10 +0100
Subject: [PATCH -next] pinctrl: mediatek: Fix include directive
In-Reply-To: <1426089920-24818-1-git-send-email-linux@roeck-us.net>
References: <1426089920-24818-1-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkdbfqCUPY_vqpif7jtdxy5E9Ei_XWojunJQ3ONpRKe1Lng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 5:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> Fix the following build failure:
>
> In file included from drivers/pinctrl/mediatek/pinctrl-mt8135.c:24:0:
> drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h:19:32: fatal error:
>         pinctrl-mtk-common.h: No such file or directory
>
> seen when building arm:multi_v7_defconfig.
>
> Fixes: 94097d89c145 ("pinctrl: mediatek: Add Pinctrl/GPIO driver for mt8135.")
> Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Patch applied with Paul's Review tag, sorry for lagging
behind on mail :(

Yours,
Linus Walleij
