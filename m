From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 10 Nov 2014 12:05:17 +0100
Subject: ARM: at91: CONFIG_ARCH_AT91SAM9G45
Message-ID: <1415617517.4862.44.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Your commit 4bf7753b8ab7 ("ARM: at91: remove at91sam9g45/9m10 legacy
board support") landed in today's linux-next (ie, next-20141110). It
removed the Kconfig symbol ARCH_AT91SAM9G45.

There are still two checks for CONFIG_ARCH_AT91SAM9G45 in next-20141110
(one in arch/arm/mach-at91/Makefile.boot and one in
arch/arm/mach-at91/board.h). Are one or more patches to remove these
checks queued somewhere?


Paul Bolle
