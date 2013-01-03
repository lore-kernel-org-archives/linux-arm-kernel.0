From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 21:44:51 +0000
Subject: [PATCH v4 10/19] irqchip: Move ARM gic.h to
 include/linux/irqchip/arm-gic.h
In-Reply-To: <1357235668-9450-11-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-11-git-send-email-robherring2@gmail.com>
Message-ID: <201301032144.52079.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that we have GIC moved to drivers/irqchip and all GIC DT init for
> platforms using irqchip_init, move gic.h and update the remaining
> includes.

Can you elaborate on why this is done? Does any other code rely on the
header file being globally visible, or is there a more general reason
to move header files out of asm/ ?

	Arnd
