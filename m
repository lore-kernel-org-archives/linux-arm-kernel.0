From: julia@diku.dk (Julia Lawall)
Date: Wed, 1 Sep 2010 17:40:49 +0200 (CEST)
Subject: question about arch/arm/mach-h720x/include/mach/irqs.h
Message-ID: <Pine.LNX.4.64.1009011738380.32566@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file arch/arm/mach-h720x/include/mach/irqs.h contains the following 
code:

/* Enable mask for multiplexed interrupts */
#define IRQ_ENA_MUX	(1<<IRQ_TIMERX) | (1<<IRQ_GPIOA) | (1<<IRQ_GPIOB) | \
 			(1<<IRQ_GPIOC) 	| (1<<IRQ_GPIOD) | (1<<IRQ_GPIOE) | \
 			(1<<IRQ_TIMERX)

This code includes the expression (1<<IRQ_TIMERX) twice.  Could the second 
(1<<IRQ_TIMERX) just be dropped, or was something else intended?

thanks,
julia
