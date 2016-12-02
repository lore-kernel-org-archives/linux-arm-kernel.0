From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Dec 2016 13:40:46 +0100
Subject: [RESEND PATCH] pinctrl: mt8173: set GPIO16 to usb iddig mode
In-Reply-To: <1480472491-4644-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1480472491-4644-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <CACRpkdbUebNHcHyQ+Pi_yfyLBB021HznPfoUv2SU0uh1_3RocA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 3:21 AM, Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> the default mode of GPIO16 pin is gpio, when set EINT16 to
> IRQ_TYPE_LEVEL_HIGH, no interrupt is triggered, it can be
> fixed when set its default mode as usb iddig.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Patch applied with Hongzhou's ACK!

Yours,
Linus Walleij
