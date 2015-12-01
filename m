From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 11:12:16 +0100
Subject: [PATCH] pinctrl: update document for
 pinconf_generic_parse_dt_config
In-Reply-To: <1448453603-38980-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1448453603-38980-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CACRpkdZ_9EOA2PVcPQgoM2UHor5jdtsGBSzomYEn0hOJEF=g1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 1:13 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:

> The returned configs from pinconf_generic_parse_dt_config() is
> duplicated from original. Make it clear it must be freed when no
> longer necessary.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Patch applied.

> It seems memleak in pinctrl-mtk-common.c[1] is not alone. After a quick
> glance I notice similar issues in drivers/pinctrl/pinctrl-at91-pio4.c and
> drivers/pinctrl/nomadik/pinctrl-abx500.c.

Patches fixing them are coming? ;)

Yours,
Linus Walleij
