From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Thu, 25 Mar 2010 12:50:53 +0100
Subject: [PATCH] i.MX25: Define address mapping macros
In-Reply-To: <20100325093617.GA16329@pengutronix.de>
References: <20100325085057.GG2328@darwin>
	<20100325093617.GA16329@pengutronix.de>
Message-ID: <20100325115053.GH2328@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

El Thu, Mar 25, 2010 at 10:36:17AM +0100 Uwe Kleine-K?nig ha dit:

> Hello Matthias,
> 
> On Thu, Mar 25, 2010 at 09:50:57AM +0100, Matthias Kaehlcke wrote:
> > Add macros for mapping physical addresses of i.MX25 registers to virtual
> > addresses
> Where do you need them?  MX25_IO_ADDRESS isn't enough?

MX25_AIPS1_IO_ADDRESS is used in arch/arm/plat-mxc/include/mach/debug-macro.S:

#define UART_VADDR  MX25_AIPS1_IO_ADDRESS(UART1_BASE_ADDR)

i added the other two for completeness

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

              We build too many walls and not enough bridges
                             (Isaac Newton)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
