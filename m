From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 Aug 2017 09:44:12 +0100
Subject: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
In-Reply-To: <20170814064355.foiilzr5cmwk65hr@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-3-wsa@the-dreams.de>
 <20170523071819.4zpdef7ofzz3moil@dell>
 <20170813133445.vqbfelwshvrififp@ninjato>
 <20170814064355.foiilzr5cmwk65hr@dell>
Message-ID: <20170814084412.dfbsqfwrgmy5bsu3@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Aug 2017, Lee Jones wrote:

> On Sun, 13 Aug 2017, Wolfram Sang wrote:
> 
> > On Tue, May 23, 2017 at 08:18:19AM +0100, Lee Jones wrote:
> > > On Mon, 22 May 2017, Wolfram Sang wrote:
> > > 
> > > > include/linux/i2c is not for client devices. Move the header file to a
> > > > more appropriate location.
> > > > 
> > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > ---
> > > >  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
> > > >  arch/arm/mach-omap1/board-h2.c          | 2 +-
> > > >  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
> > > >  arch/arm/mach-omap1/board-h3.c          | 2 +-
> > > >  arch/arm/mach-omap1/board-osk.c         | 2 +-
> > > >  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
> > > >  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
> > > 
> > > >  drivers/mfd/tps65010.c                  | 2 +-
> > > 
> > > For my own reference:
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Same here: ok for 4.14 or something needed?
> 
> Can this patch be applied on its own, or does it have dependencies?

Even if it doesn't, it still requires Acks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
