From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 9 Mar 2015 07:48:51 +0000
Subject: [PATCH v3 0/8] irqchip: New driver for ST's SysCfg controlled IRQs
In-Reply-To: <20150308040238.GC21207@io.lakedaemon.net>
References: <1424272444-16230-1-git-send-email-lee.jones@linaro.org>
 <20150308040238.GC21207@io.lakedaemon.net>
Message-ID: <20150309074851.GJ3318@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 08 Mar 2015, Jason Cooper wrote:

> Lee,
> 
> On Wed, Feb 18, 2015 at 03:13:56PM +0000, Lee Jones wrote:
> > Rebased (again) and resending.
> >  
> > This driver enables IRQs which are controlled using System Configuration
> > registers.  Without it Performance Monitoring, Core Sight Tracing and some
> > L2 Caches will fail to function.
> >  
> > v2 => v3:
> >  - Removed filename from header as suggested by Thomas
> > 
> > v1 => v2:
> >  - Fixed up Jason's review comments
> > 
> > Lee Jones (8):
> >   dt: bindings: Supply shared ST IRQ defines
> >   irqchip: Supply new driver for STi based devices
> >   irqchip: irq-st: Add documentation for STi based syscfg IRQs
> ...
> >  .../interrupt-controller/st,sti-irq-syscfg.txt     |  35 ++++
> ...
> >  drivers/irqchip/Kconfig                            |   7 +
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-st.c                           | 206 +++++++++++++++++++++
> >  include/dt-bindings/interrupt-controller/irq-st.h  |  30 +++
> ...
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
> >  create mode 100644 drivers/irqchip/irq-st.c
> >  create mode 100644 include/dt-bindings/interrupt-controller/irq-st.h
> 
> Patches 1-3 applied to irqchip/st several days ago.  Sorry for not letting you
> know earlier.  I'm just getting things back in order from hardware failures in
> my build machine *and* my mailserver.  It's been a rough week.  :-/

Thanks Jason.

> Let me know if you'd like to use that branch as a stable base.

I do not wish to do that.  Rebase at will.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
