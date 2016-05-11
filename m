From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 May 2016 13:56:11 +0200
Subject: [PATCH 6/6] pinctrl: mt8173: set GPIO16 to usb iddig mode
In-Reply-To: <1462868614-20602-7-git-send-email-chunfeng.yun@mediatek.com>
References: <1462868614-20602-1-git-send-email-chunfeng.yun@mediatek.com>
 <1462868614-20602-7-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <CACRpkdaeD5mk7LXEWnE0=Xute8-JA-fa4tVt4fYhujEXeq2+9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 10:23 AM, Chunfeng Yun
<chunfeng.yun@mediatek.com> wrote:

> the default mode of GPIO16 pin is gpio, when set EINT16 to
> IRQ_TYPE_LEVEL_HIGH, no interrupt is triggered, it can be
> fixed when set its default mode as usb iddig.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

This looks like it can be merged orthogonally to all the
other patches, but I don't understand the patch or if it
is correct.

Hongzhou/Yingjoe, can either of you review this patch?

Yours,
Linus Walleij
