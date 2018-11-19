From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Nov 2018 13:07:41 -0600
Subject: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <CAGp9LzpgZsj79Tf5Hee45Wt6ag+WHV0SMWd6qvvtj4G3pzAZKQ@mail.gmail.com>
References: <20181116220540.17222-1-robh@kernel.org>
 <20181116220540.17222-4-robh@kernel.org>
 <CAGp9LzpgZsj79Tf5Hee45Wt6ag+WHV0SMWd6qvvtj4G3pzAZKQ@mail.gmail.com>
Message-ID: <CAL_Jsq+r6JrKKcHnmBSncdEaw=7Jhobv_w8PJrH=sbY2qtxOTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 5:46 PM Sean Wang <sean.wang@kernel.org> wrote:
>
> On Fri, Nov 16, 2018 at 2:06 PM Rob Herring <robh@kernel.org> wrote:
> >
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Sean Wang <sean.wang@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: linux-mediatek at lists.infradead.org
> > Cc: linux-gpio at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Sean Wang <sean.wang@kernel.org>

BTW, messages to you bounce:

<sean.wang@mediatek.com> (expanded from <sean.wang@kernel.org>): host
    mailgw01.mediatek.com[216.200.240.184] said: 550 Relaying mail to
    sean.wang at mediatek.com is not allowed (in reply to RCPT TO command)

Perhaps you need your kernel.org account to route somewhere else.

Rob
