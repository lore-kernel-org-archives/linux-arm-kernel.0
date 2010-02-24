From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 14:40:54 +0000
Subject: [PATCH 3/7] ARM: U300: set f_max to 24 MHz for MMCI
In-Reply-To: <A6D19A13FE030A409EC4362C172E091F0E963F15@eseldmw101.eemea.ericsson.se>
References: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
	<20100221210740.GA3528@n2100.arm.linux.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E9355A2@eseldmw101.eemea.ericsson.se>
	<20100224125002.GA19641@n2100.arm.linux.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E963F15@eseldmw101.eemea.ericsson.se>
Message-ID: <20100224144054.GA21680@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 03:35:46PM +0100, Linus Walleij wrote:
> If a generic PrimeCell DMA doesn't work out, we will have to fork
> the driver instead, since we cannot even use it with the U8500
> without DMA support, perhaps this is just as good anyway since
> we wouldn't be disturbing RealView etc with our patches. But
> it'll lead to some code duplication.

Versatile and Realview both have DMA infrastructure based around the
PL080 and a routing selector for the DMA signals.  However, no one
has yet come up with a suitable way to deal with this yet...
