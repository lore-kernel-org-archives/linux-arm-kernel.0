From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 11:17:10 +0200
Subject: [PATCH v2 06/11] pinctrl: mediatek: Add Pinctrl/GPIO driver for
 mt6397.
In-Reply-To: <1432015882-8646-7-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-7-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdYZ74avT1kKoKUc-kF9BBRrA4X_sj8CCk=K=vOjzhAYTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 8:11 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Add mt6397 support using mediatek common pinctrl driver.
>
> mt6397 is a PMIC, and pinctrl/GPIO is part of 6397 chip.
> Pinctrl/GPIO driver should obtain regmap from PMIC,
> so adding this support to common code.
>
> Also, mt6397 is no need to support interrupt controller,
> so changing common code to skip it.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

APplied this version instead.

Yours,
Linus Walleij
