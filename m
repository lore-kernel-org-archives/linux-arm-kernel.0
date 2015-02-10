From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Feb 2015 16:24:56 +0800
Subject: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
In-Reply-To: <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CACRpkdbhuouBuXv0X4M5VHikvWV_rLFd+LjU=PndgTVm4+retg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 2:15 PM, Chaotian Jing
<chaotian.jing@mediatek.com> wrote:

> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> MTK EINT does not support generating interrupt on both edges.
> Emulate this by changing edge polarity while enable irq,
> set types and interrupt handling. This follows an example of
> drivers/gpio/gpio-mxc.c.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Patch applied on top of the rest of the mtk pinctrl support.
Adding Hongzhou's ACK on top.

Yours,
Linus Walleij
