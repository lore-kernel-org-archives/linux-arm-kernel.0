From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 13:01:06 +0100
Subject: [PATCH v3] pinctrl: mediatek: Adjust mt8173 pinctrl kconfig
In-Reply-To: <1426257652-16779-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
 <1426257652-16779-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CACRpkdZyhgRDVAiX3UCpCqxQUeSU2a3ktUbVNnStsrXkR7zT-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 3:40 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:

> Hi Linus,
>
> Yet another version. Changed based on Arnd's suggestion to make config
> options for PINCTRL_MT8135 & PINCTRL_MT8173 more consist. This is based
> on mtk-staging in your tree. If you think this is OK, please applied or
> squash this into previous change. Thanks.
>
> Old patch can be found at:
> http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000057.html
>
> Joe.C
>
> 8<-------------------------------------------------------
> ARM64 maintainer doesn't want to add MACH_* for each SoC.
> Adjust mt8173 pinctrl kconfig entry so user can manually select it.
>
> Also make PINCTRL_MT8135 selectable when COMPILE_TEST is enabled.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

This last version of the patch applied.

Yours,
Linus Walleij
