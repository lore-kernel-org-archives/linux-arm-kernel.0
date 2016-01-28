From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jan 2016 11:15:35 +0100
Subject: [PATCH v4 4/5] pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver
 for mt2701
In-Reply-To: <1453857883-28436-5-git-send-email-biao.huang@mediatek.com>
References: <1453857883-28436-1-git-send-email-biao.huang@mediatek.com>
 <1453857883-28436-5-git-send-email-biao.huang@mediatek.com>
Message-ID: <CACRpkdaAP=dK1g-fM+57YZCBCRSryc24UScpRAKVPq8_BwsVsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 2:24 AM, Biao Huang <biao.huang@mediatek.com> wrote:

> Add mt2701 support using mediatek common pinctrl driver.
> MT2701 have some special pins need an extra setting register
> than other ICs, so adding this support to common code.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> Acked-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Patch merged to my devel-mt2701 branch.

Yours,
Linus Walleij
