From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 13 Aug 2017 15:34:45 +0200
Subject: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
In-Reply-To: <20170523071819.4zpdef7ofzz3moil@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-3-wsa@the-dreams.de>
 <20170523071819.4zpdef7ofzz3moil@dell>
Message-ID: <20170813133445.vqbfelwshvrififp@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 08:18:19AM +0100, Lee Jones wrote:
> On Mon, 22 May 2017, Wolfram Sang wrote:
> 
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
> >  arch/arm/mach-omap1/board-h2.c          | 2 +-
> >  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
> >  arch/arm/mach-omap1/board-h3.c          | 2 +-
> >  arch/arm/mach-omap1/board-osk.c         | 2 +-
> >  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
> >  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
> 
> >  drivers/mfd/tps65010.c                  | 2 +-
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Same here: ok for 4.14 or something needed?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170813/cc212666/attachment.sig>
