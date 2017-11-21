From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 21 Nov 2017 21:09:22 +0100
Subject: [PATCH 3/6] arm: dts: marvell: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <CAL_JsqJhq7TqdaS+i8yk8rRJM0hH2hyk8eybXsnR0D8QoncXZg@mail.gmail.com>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-3-robh@kernel.org>
 <CAL_JsqJhq7TqdaS+i8yk8rRJM0hH2hyk8eybXsnR0D8QoncXZg@mail.gmail.com>
Message-ID: <20171121200922.GD30040@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 12:29:48PM -0600, Rob Herring wrote:
> On Thu, Nov 9, 2017 at 4:26 PM, Rob Herring <robh@kernel.org> wrote:
> > "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
> > property. This is probably because the binding was the precursor to the phy
> > binding.
> >
> > Fixes the following warning in Marvell dts files:
> >
> > Warning (phys_property): Missing property '#phy-cells' in node ...
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Please apply to Marvell tree.
> 
> Ping.
> 
> Arnd, can you apply if you'd like the warnings fixed and Marvell
> maintainers don't respond.

Hi Rob

Patches submitted a week before the merge window opens are generally
deferred to the next cycle. I expect that once -rc1 is out, Gregory
will pick up this patch.

     Andrew
