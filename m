From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 10:58:44 -0800
Subject: [PATCH] pcmcia: at91_cf: depend on !ARCH_MULTIPLATFORM
In-Reply-To: <54CA0021.7000706@atmel.com>
References: <1421173685-21559-1-git-send-email-alexandre.belloni@free-electrons.com>
 <54B63517.9030809@atmel.com> <54CA0021.7000706@atmel.com>
Message-ID: <20150129185844.GB18628@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 10:40:49AM +0100, Nicolas Ferre wrote:
> Le 14/01/2015 10:21, Nicolas Ferre a ?crit :
> > Le 13/01/2015 19:28, Alexandre Belloni a ?crit :
> >> Until the driver is corrected to stop including mach/at91_ramc.h and using
> >> mach/io.h, it won't compile in a ARCH_MULTIPLATFORM configuration.
> >>
> >> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Arnd, Olof, Kevin,
> 
> It seems that nobody is taking this lonely patch. It can be interesting
> to have it for 3.20.
> So, can you please add it to the "drivers" branch so that the switch to
> multi-platform is possible soon.
> 
> Here is the reference of it in patchwork:
> 
> https://patchwork.kernel.org/patch/5623391/
> 
> Tell me if it's better to ask Greg or Andrew.

This is small and trivial enough that I think we can just take it. Applied to
next/drivers.


-Olof
