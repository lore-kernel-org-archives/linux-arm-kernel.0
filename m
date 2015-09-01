From: slash.tmp@free.fr (Mason)
Date: Tue, 01 Sep 2015 19:57:33 +0200
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <yw1xtwreysnr.fsf@unicorn.mansr.com>
References: <55E5CED8.7000408@free.fr> <yw1xtwreysnr.fsf@unicorn.mansr.com>
Message-ID: <55E5E70D.4060006@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

M?ns Rullg?rd wrote:

> Mason wrote:
> 
>> I'm trying to port to my ARM platform: IRQ handling code written for MIPS.
>> https://github.com/mansr/linux-tangox/blob/master/drivers/irqchip/irq-tangox.c
> 
> Go get the latest version of that file.  It should work on ARM now.

It would probably have taken me days to figure out I could just delete
the arch-dependent code. Linux internals are so hard to grok... <sigh>

Would you like me to ask if they can send you a dev board? :-)

By the way, it seems the generic UART driver does not use interrupts,
which would explain why the console works despite my busted device tree.
Does that mean that the driver polls? (I'll take a closer look tomorrow.)

Is it not worth it to use interrupts for slow devices?

Regards.
