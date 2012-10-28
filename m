From: marex@denx.de (Marek Vasut)
Date: Sun, 28 Oct 2012 23:38:03 +0100
Subject: [PATCH v2 1/5] ARM: PXA: Add z2-usb-switch driver
In-Reply-To: <CA+E=qVdEPcBobVDODcyjZkbhZD6KXmGR7Fo5T40GRSPWNhujsQ@mail.gmail.com>
References: <CA+E=qVc1MGPQoWZWQAcv-NEh8WpLoqeTYLQz4iFjiOyfc9CX5w@mail.gmail.com>
 <201210282257.48770.marex@denx.de>
 <CA+E=qVdEPcBobVDODcyjZkbhZD6KXmGR7Fo5T40GRSPWNhujsQ@mail.gmail.com>
Message-ID: <201210282338.03505.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Vasily Khoruzhick,

> On Mon, Oct 29, 2012 at 12:57 AM, Marek Vasut <marex@denx.de> wrote:
> > Dear Vasily Khoruzhick,
> 
> Dear Marek Vasut,
> 
> >> This driver controls mode of USB port #2 pins - device or host.
> > 
> > Please supply proper commit message. This short message describes
> > nothing.
> 
> OK, "This driver allows user to choose USB port #2 mode between device
> and host" - that would be OK?

Please describe why is this needed at all and what it does.

[...]

> > I wonder if we have no better means to control enforcement of mode.
> 
> Why? sysfs fits nicely.

Because if there is already an API to implement this OTG in kernel, you should 
use that and not reinvent wheel.

[...]

Best regards,
Marek Vasut
