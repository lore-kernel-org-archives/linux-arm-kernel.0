From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 25 Mar 2010 20:01:32 +0200
Subject: [PATCH] i.MX25: Define address mapping macros
In-Reply-To: <20100325115053.GH2328@darwin>
References: <20100325085057.GG2328@darwin>
	<20100325093617.GA16329@pengutronix.de>
	<20100325115053.GH2328@darwin>
Message-ID: <20100325180127.GB27698@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, Mar 25, 2010 at 12:50:53PM +0100, Matthias Kaehlcke wrote:
> El Thu, Mar 25, 2010 at 10:36:17AM +0100 Uwe Kleine-K?nig ha dit:
> 
> > On Thu, Mar 25, 2010 at 09:50:57AM +0100, Matthias Kaehlcke wrote:
> > > Add macros for mapping physical addresses of i.MX25 registers to virtual
> > > addresses
> > Where do you need them?  MX25_IO_ADDRESS isn't enough?
> 
> MX25_AIPS1_IO_ADDRESS is used in arch/arm/plat-mxc/include/mach/debug-macro.S:
> 
> #define UART_VADDR  MX25_AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
> 
> i added the other two for completeness

See http://thread.gmane.org/gmane.linux.ports.arm.kernel/75691 for a different 
approach, and discussion of the general problem.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
