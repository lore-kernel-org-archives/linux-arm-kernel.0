From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 08:55:12 -0500
Subject: [PATCH] irqchip: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <alpine.DEB.2.21.1809081414150.1402@nanos.tec.linutronix.de>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-24-robh@kernel.org>
 <alpine.DEB.2.21.1809081414150.1402@nanos.tec.linutronix.de>
Message-ID: <CAL_JsqJVbc4ecRfSp4=crH0Ci9duP-2_mZmKW-5NW-zZv4QwQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 27 Aug 2018, Rob Herring wrote:
>
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Should I take it or do you want to take it with others? If the latter,
> acked-by-me.

Please take it. There's no dependency.

Rob
