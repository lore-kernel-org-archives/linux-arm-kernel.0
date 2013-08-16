From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Aug 2013 09:00:47 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.12
In-Reply-To: <20130816063715.GI7035@quad.lixom.net>
References: <20130814201630.GH13964@titan.lakedaemon.net>
 <20130816063715.GI7035@quad.lixom.net>
Message-ID: <20130816130047.GS13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 11:37:15PM -0700, Olof Johansson wrote:
> On Wed, Aug 14, 2013 at 04:16:30PM -0400, Jason Cooper wrote:
> > Arnd, Olof,
> > 
> > Here's the DT changes for v3.12 that didn't accompany driver conversions
> > (MBus, mv643xx_eth, clocksource, irqchip, msi/pci, etc).  I've attached
> > the conflict resolution below.  The small conflict in the binding
> > documentation is against arm-soc/for-next as well.  The rest is against
> > mvebu/boards.
> > 
> > Gregory CLEMENT (1):
> >       ARM: dts: mvebu: Introduce a new compatible string for mv64xxx-i2c
> 
> I didn't see any review of this patch by a device tree maintainer.
> 
> Also, there's a conflict with f480adaf1b7130ad43760f627b762f771fcfc5f5
> which is part of -rc5. That patch was merged through the i2c maintainer,
> so it would seem appropriate to do the same to this. Please get bindings
> acks or send the bindings update through a devicetree maintainer. dts/dtsi
> updates should still go through arm-soc. Given that the other update went in
> through the i2c maintainer, it could be appropriate to at least give him the
> choice of taking the bindings portion of this one as well.

You're right.  Gregory, I'm going to drop this one from mvebu/dt.
Please resubmit it as two patches (binding/dts changes) including the
devicetree mailinglist.

Olof, v2 of the pull (see, I didn't say 'PR' :) ) on it's way.

thx,

Jason.
