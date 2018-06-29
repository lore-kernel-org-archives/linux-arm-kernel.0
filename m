From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Jun 2018 14:21:10 +0200
Subject: [PATCH 4/7] pinctrl: mt7622: stop using the deprecated
 pinctrl_add_gpio_range
In-Reply-To: <098100772163e54fe5ca49576042edbfaf3807a5.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <098100772163e54fe5ca49576042edbfaf3807a5.1529639050.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdYn3SJd=X1R-xLhJraqk6TWutmOVRZ2ROc8ih_fT_6MEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> If the pinctrl node has the gpio-ranges property, the range will be added
> by the gpio core and doesn't need to be added by the pinctrl driver.
>
> But for keeping backward compatibility, an explicit pinctrl_add_gpio_range
> is still needed to be called when there is a missing gpio-ranges in pinctrl
> node in old dts files.
>
> Cc: stable at vger.kernel.org
> Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
