From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 20 Jan 2014 08:49:08 +0400
Subject: [PATCH v2 0/3] ARM: clps711x: IRQCHIP driver
In-Reply-To: <20131229084340.10a4abdfc5815a709d7a6cc6@mail.ru>
References: <1387454214-1171-1-git-send-email-shc_work@mail.ru>
 <20131229084340.10a4abdfc5815a709d7a6cc6@mail.ru>
Message-ID: <20140120084908.751d1ffcf0dcb32beb32c54f@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 Dec 2013 08:43:40 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

> On Thu, 19 Dec 2013 15:56:54 +0400
> Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> > This series is devoted to new CLPS711X irqchip driver.
> > The driver designed for booting from ATAGS and devicetree.
> > 
> > Alexander Shiyan (3):
> >   ARM: clps711x: Add CLPS711X irqchip driver
> >   ARM: dts: clps711x: Add bindings documentation for CLPS711X irqchip
> >     driver
> >   ARM: clps711x: Migrate CLPS711X subarch to the new irqchip driver
> > 
> >  .../interrupt-controller/cirrus,clps711x-intc.txt  |  41 ++++
> >  arch/arm/Kconfig                                   |   2 -
> >  arch/arm/mach-clps711x/board-autcpu12.c            |   2 -
> >  arch/arm/mach-clps711x/board-cdb89712.c            |   2 -
> >  arch/arm/mach-clps711x/board-clep7312.c            |   2 -
> >  arch/arm/mach-clps711x/board-edb7211.c             |   2 -
> >  arch/arm/mach-clps711x/board-p720t.c               |   2 -
> >  arch/arm/mach-clps711x/common.c                    | 201 +----------------
> >  arch/arm/mach-clps711x/common.h                    |   5 +-
> >  arch/arm/mach-clps711x/include/mach/clps711x.h     |  16 --
> >  drivers/irqchip/Kconfig                            |   8 +
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-clps711x.c                     | 243 +++++++++++++++++++++
> >  13 files changed, 299 insertions(+), 228 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
> >  create mode 100644 drivers/irqchip/irq-clps711x.c
> > 
> > -- 
> 
> Ping.

Silence more than two weeks from the last post on this series.
Arnd, Olof, I beg to apply these patches to arm-soc.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
