From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Sep 2011 21:36:27 -0400 (EDT)
Subject: [PATCH 0/6] OMAP/Davinci debug UART code cleanup
In-Reply-To: <87fwk91fhy.fsf@ti.com>
References: <87fwk91fhy.fsf@ti.com>
Message-ID: <alpine.LFD.2.00.1109062135520.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2011, Kevin Hilman wrote:

> Hi Nico,
> 
> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Let's remove some of the most offending parts of this code.
> >
> > [PATCH 1/6] ARM: add an extra temp register to the addruart low level debugging macro
> > [PATCH 2/6] ARM: plat-omap: make OMAP_UART_INFO into a relative offset
> > [PATCH 3/6] ARM: mach-omap1: clean up debug-macro.S
> > [PATCH 4/6] ARM: mach-omap2: clean up debug-macro.S
> > [PATCH 5/6] ARM: mach-davinci: make DAVINCI_UART_INFO into a relative offset
> > [PATCH 6/6] ARM: mach-davinci: clean up debug-macro.S
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> 
> Also boot tested with CONFIG_DEBUG_LL on davinci/dm355 so for patches 1,
> 5 & 6, feel free to add:
> 
> Tested-by: Kevin Hilman <khilman@ti.com>

Thanks.


Nicolas
