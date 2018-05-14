From: jhogan@kernel.org (James Hogan)
Date: Mon, 14 May 2018 22:42:02 +0100
Subject: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
In-Reply-To: <20180514213719.o6ceftp2quem3s7f@ninjato>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
 <20180514213719.o6ceftp2quem3s7f@ninjato>
Message-ID: <20180514214201.GA29541@jamesdev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 11:37:20PM +0200, Wolfram Sang wrote:
> > diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
> > index 4e79dbd54a33..fa75d75b5ba9 100644
> > --- a/arch/mips/alchemy/board-gpr.c
> > +++ b/arch/mips/alchemy/board-gpr.c
> > @@ -29,7 +29,7 @@
> >  #include <linux/leds.h>
> >  #include <linux/gpio.h>
> >  #include <linux/i2c.h>
> > -#include <linux/i2c-gpio.h>
> > +#include <linux/platform_data/i2c-gpio.h>
> >  #include <linux/gpio/machine.h>
> >  #include <asm/bootinfo.h>
> >  #include <asm/idle.h>

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180514/3204a488/attachment.sig>
