From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Nov 2010 13:37:54 +0000
Subject: [PATCH 00/54] ARM irq_data conversion.
In-Reply-To: <20101130131105.GA15575@mail.wantstofly.org>
References: <20101130131105.GA15575@mail.wantstofly.org>
Message-ID: <20101130133754.GD32368@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:11:05PM +0100, Lennert Buytenhek wrote:

>  arch/arm/mach-s3c64xx/irq-eint.c         |   34 +++---
>  arch/arm/plat-samsung/include/plat/pm.h  |    4 +-
>  arch/arm/plat-samsung/irq-uart.c         |   44 ++++----
>  arch/arm/plat-samsung/irq-vic-timer.c    |   22 ++--
>  arch/arm/plat-samsung/pm.c               |    7 +-

I've already sent changes which cover some of these (everything that
appears on s3c64xx anyway) and use the opportunity of doing the
conversion to introduce some trivial optimisations.  Hopefully Kukjin
and/or Ben will get a chance to look at them soon.
