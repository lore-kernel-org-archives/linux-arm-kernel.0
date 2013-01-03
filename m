From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Jan 2013 23:09:48 +0100
Subject: [PATCH v4 10/19] irqchip: Move ARM gic.h to
 include/linux/irqchip/arm-gic.h
In-Reply-To: <201301032144.52079.arnd@arndb.de>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-11-git-send-email-robherring2@gmail.com>
 <201301032144.52079.arnd@arndb.de>
Message-ID: <20130103230948.50720073@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 3 Jan 2013 21:44:51 +0000, Arnd Bergmann wrote:
> On Thursday 03 January 2013, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Now that we have GIC moved to drivers/irqchip and all GIC DT init
> > for platforms using irqchip_init, move gic.h and update the
> > remaining includes.
> 
> Can you elaborate on why this is done? Does any other code rely on the
> header file being globally visible, or is there a more general reason
> to move header files out of asm/ ?

>From what I remember, Russell said that if the driver moves away from
arch/arm/, so should the header file.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
