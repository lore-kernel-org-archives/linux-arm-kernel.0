From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 26 Oct 2014 16:26:53 +0100 (CET)
Subject: [PATCH v8 0/9] initial suport for Alphascale ASM9260
In-Reply-To: <544D0786.2070401@rempel-privat.de>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <544D0786.2070401@rempel-privat.de>
Message-ID: <alpine.DEB.2.11.1410261626120.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 26 Oct 2014, Oleksij Rempel wrote:

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

If the parts are independent from each other there is no reason to
have a big combined patch pile.

Thanks,

	tglx
