From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 10:44:17 +0200
Subject: Fix me in netx-regs.h
In-Reply-To: <CAPDOMVhdK67Fc5KsamL8XKdRNy0VjKB3ub24krgwmRsnZGtQNQ@mail.gmail.com>
References: <CAPDOMVhdK67Fc5KsamL8XKdRNy0VjKB3ub24krgwmRsnZGtQNQ@mail.gmail.com>
Message-ID: <11713455.tffm2SOdyn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014 00:16:26 Nick Krause wrote:
> Hey Russell,
> I did give thought to our previous conversations and I will still do
> fix mes but am going to be more careful
> with I submit them. Furthermore it seems  #define
> NETX_GPIO_COUNTER_CTRL_GPIO_RE is not defined
> correctly. As the maintainer what should I define it to?

Are you offering to become the maintainer for netx?

Try to get hold of a reference manual for the chip. More importantly
than the fixme, I think we should be able to move this platform into
ARCH_MULTIPLATFORM. This means moving the contents of the header files
into the places where they are used, and finding a better home for the
pfifo driver.

	Arnd
