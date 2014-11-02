From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 22:11:23 -0400
Subject: [PATCH v8 0/9] initial suport for Alphascale ASM9260
In-Reply-To: <544D0786.2070401@rempel-privat.de>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <544D0786.2070401@rempel-privat.de>
Message-ID: <20141102021123.GQ3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 26, 2014 at 03:39:02PM +0100, Oleksij Rempel wrote:
> Will it be better to split this patch set?
> 
> For example:
> part 1
> >   ARM: add mach-asm9260
> >   ARM: add lolevel debug support for asm9260
> part2
> >   ARM: irqchip: mxs: prepare driver for HW with different offsets
> >   ARM: irqchip: mxs: add Alpascale ASM9260 support
> and all other patches separately.
> 
> this will reduce review time for you and give some hope for me :D

I honestly prefer to keep the series together.  The subject lines make
it clear which parts I need to worry about merging.  The big thing is
if there are compile-time dependencies between the different subsystems.
It doesn't look like there are, but if so, just bring it to our
attention.

thx,

Jason.
