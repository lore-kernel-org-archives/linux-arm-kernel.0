From: slash.tmp@free.fr (Mason)
Date: Thu, 11 May 2017 18:04:38 +0200
Subject: Supporting "software interrupts" in an irqchip driver
Message-ID: <6a3bc1b5-0df9-c5f8-6102-60427d4cf616@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas, Marc, Mark, (and the funky bunch)

The interrupt controller on my SoC supports so-called "software"
interrupts, meaning that the HW exposes a 32-bit register in which
SW can write some value.

If the value written is non-zero, then interrupt 0 is raised.

How is such a contraption defined in a device tree?

Are there good drivers to read as examples?
drivers/irqchip/irq-mips-cpu.c mentions "software interrupts"
in the context of "which we don't really use or support."

Regards.
