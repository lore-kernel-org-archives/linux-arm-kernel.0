From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Dec 2015 23:52:01 +0100
Subject: [PATCH 4/5] pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver for
 mt2701
In-Reply-To: <1448527472-20651-5-git-send-email-biao.huang@mediatek.com>
References: <1448527472-20651-1-git-send-email-biao.huang@mediatek.com>
 <1448527472-20651-5-git-send-email-biao.huang@mediatek.com>
Message-ID: <CACRpkda2vgrVEisH=akc5aj6h4LW+mBTqgbAiF3E=3zcu6A28A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 9:44 AM, Biao Huang <biao.huang@mediatek.com> wrote:

> Add mt2701 support using mediatek common pinctrl driver.
> MT2701 have some special pins need an extra setting register
> than other ICs, so adding this support to common code.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

This looks uncontroversial, but I would like to have some of the
other Mediatek driver authors send their Ack/Review tags,
so Hongzhou & Yingjoe: can you review this and the other
patch to the pin control driver?

Yours,
Linus Walleij
