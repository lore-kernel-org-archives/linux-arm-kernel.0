From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Jan 2015 15:21:10 +0100
Subject: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
In-Reply-To: <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CACRpkdbncsDJ3pP0dETpho5+j+OVuaYr=YTsH8pAs7vuT_9OLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 7:15 AM, Chaotian Jing
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

Hongzhu, if you're fine with this patch can you ACK it as maintainer
of the pinctrl driver so I can merge it immediately on top of your
drivern whenever we consider it finished (and if it applies still...)

Yours,
Linus Walleij
