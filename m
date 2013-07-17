From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 18:02:33 +0100
Subject: [PATCH RFC v2 13/14] ARM: debug: move davinci debug to generic
 8250 code
In-Reply-To: <51E6887F.3090808@ti.com>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8OD-00048N-Be@rmk-PC.arm.linux.org.uk> <51E6887F.3090808@ti.com>
Message-ID: <20130717170233.GQ24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 05:35:19PM +0530, Sekhar Nori wrote:
> On 7/16/2013 10:16 PM, Russell King wrote:
> > Davinci's debugging is just a copy of the old 8250_32 code with a
> > different base address.  Incorporate this into the generic 8250
> > debug code.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Tested on DA850 EVM
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

You may wish to consider whether a Tested-by tag would be a more accurate
attributation if you actually tested the patch.
