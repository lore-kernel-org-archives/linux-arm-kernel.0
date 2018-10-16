From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 09:14:38 +0200
Subject: [PATCH 3/3] clocksource/drivers/ep93xx: Create a state container
In-Reply-To: <237452dc-623d-8306-1537-7b4c5e192d21@linaro.org>
References: <20180930211608.5516-1-linus.walleij@linaro.org>
 <20180930211608.5516-3-linus.walleij@linaro.org>
 <237452dc-623d-8306-1537-7b4c5e192d21@linaro.org>
Message-ID: <CACRpkdbs=36M4WBmqZxL96Us5Z+DL5a_HHkUEwZ8NcyXrnuHwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 11:22 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 30/09/2018 23:16, Linus Walleij wrote:

> > +struct ep93tmr {
> > +     void __iomem *base;
> > +     struct clock_event_device clkevt;
> > +};
>
> Is it possible to replace by timer_of structure ?

Not right now, because this platform does not (yet) use
device tree.

Yours,
Linus Walleij
