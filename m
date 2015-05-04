From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 4 May 2015 11:03:31 +0200
Subject: [PATCH v2 1/2] ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for
 mt8135.
In-Reply-To: <1430462971-28195-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1430462971-28195-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CABuKBeJ=pFOwuhGrTxJ7W_-XD=qgS9=3P2aEcXo+1zm0bvd7-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-01 8:49 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
>
> Patches based on v4.1-rc1. Change according to Matthias' suggestion.
> - Remove comments on syscfg nodes
> - Sort nodes by instance address & name.
>
> ---8<--------------------------------------------------------------------
> Add pinctrl,GPIO and EINT node to mt8135.dtsi.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/mt8135-pinfunc.h | 1302 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt8135.dtsi      |   29 +
>  2 files changed, 1331 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt8135-pinfunc.h

applied to v4.1-next/dts

Thanks.
