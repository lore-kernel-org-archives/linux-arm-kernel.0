From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 28 Jan 2015 23:29:39 -0800
Subject: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
In-Reply-To: <CACRpkdbncsDJ3pP0dETpho5+j+OVuaYr=YTsH8pAs7vuT_9OLw@mail.gmail.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
 <CACRpkdbncsDJ3pP0dETpho5+j+OVuaYr=YTsH8pAs7vuT_9OLw@mail.gmail.com>
Message-ID: <1422516579.23729.7.camel@mussux00.eus.mediatek.inc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-27 at 15:21 +0100, Linus Walleij wrote:
> On Tue, Jan 27, 2015 at 7:15 AM, Chaotian Jing
> <chaotian.jing@mediatek.com> wrote:
> 
> > From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >
> > MTK EINT does not support generating interrupt on both edges.
> > Emulate this by changing edge polarity while enable irq,
> > set types and interrupt handling. This follows an example of
> > drivers/gpio/gpio-mxc.c.
> >
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> 
> Hongzhu, if you're fine with this patch can you ACK it as maintainer
> of the pinctrl driver so I can merge it immediately on top of your
> drivern whenever we consider it finished (and if it applies still...)
> 
> Yours,
> Linus Walleij

Hi Linus,

I think it's good, thank you.
Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Yours,
Hongzhou
