From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 10 Nov 2014 12:10:08 +0100
Subject: ARM: at91: CONFIG_ARCH_AT91SAM9RL
Message-ID: <1415617808.4862.49.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Your commit bcf8c7e7703b ("ARM: at91: remove at91sam9rl legacy board
support") landed in today's linux-next (ie, next-20141110). It removed
the Kconfig symbol ARCH_AT91SAM9RL.

There is still one check for CONFIG_ARCH_AT91SAM9RL in next-20141110 (in
drivers/usb/gadget/udc/atmel_usba_udc.c). Is a patch to remove this
check queued somewhere?


Paul Bolle
