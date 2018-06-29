From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Jun 2018 14:22:44 +0200
Subject: [PATCH 6/7] arm64: dts: mt7622: use gpio-ranges to pinctrl device
In-Reply-To: <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdZta2f1OKB3E1crLH1mymq26_6vU4hF=fseRt_70EDEuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Using gpio-ranges property represent which GPIOs correspond to which pins
> on MT7622 pin controllers. For details, we can see section 2.1 of
> Documentation/devicetree/bindings/gpio/gpio.txt to know how to bind pinctrl
> and gpio drivers via the "gpio-ranges" property.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
