From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 21 May 2011 00:11:01 +0200 (CEST)
Subject: [PATCH] Fix generic irq chip
In-Reply-To: <20110520220510.GC30675@n2100.arm.linux.org.uk>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1105210007440.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Russell King - ARM Linux wrote:

> As a result of c42321c (genirq: Make generic irq chip depend on
> CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
> my tree to select this symbol.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
> for Samsung.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Sorry for the confusion, that patch should have hit the arm kernel
list two weeks ago, but for whatever reason it did not.

Thanks,

	tglx
