From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Dec 2010 16:29:39 +0900
Subject: [PATCH 00/54] ARM irq_data conversion.
In-Reply-To: <20101130133754.GD32368@sirena.org.uk>
References: <20101130131105.GA15575@mail.wantstofly.org>
	<20101130133754.GD32368@sirena.org.uk>
Message-ID: <001a01cb9129$86857150$939053f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Tue, Nov 30, 2010 at 02:11:05PM +0100, Lennert Buytenhek wrote:
> 
> >  arch/arm/mach-s3c64xx/irq-eint.c         |   34 +++---
> >  arch/arm/plat-samsung/include/plat/pm.h  |    4 +-
> >  arch/arm/plat-samsung/irq-uart.c         |   44 ++++----
> >  arch/arm/plat-samsung/irq-vic-timer.c    |   22 ++--
> >  arch/arm/plat-samsung/pm.c               |    7 +-
> 
> I've already sent changes which cover some of these (everything that
> appears on s3c64xx anyway) and use the opportunity of doing the
> conversion to introduce some trivial optimisations.  Hopefully Kukjin
> and/or Ben will get a chance to look at them soon.

Hi Mark,

Oh, sorry for late.
Will check soon :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
