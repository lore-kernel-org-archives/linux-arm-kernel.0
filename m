From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Tue, 22 Jan 2013 10:34:51 -0200
Subject: [PATCH 09/15] media: coda: don't build on multiplatform
In-Reply-To: <20130122103222.27b615d7@redhat.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-10-git-send-email-arnd@arndb.de>
 <20130122035402.GC29677@S2100-06.ap.freescale.net>
 <20130122103222.27b615d7@redhat.com>
Message-ID: <20130122103451.16522151@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, 22 Jan 2013 10:32:22 -0200
Mauro Carvalho Chehab <mchehab@redhat.com> escreveu:

> Em Tue, 22 Jan 2013 11:54:04 +0800
> Shawn Guo <shawn.guo@linaro.org> escreveu:
> 
> > On Mon, Jan 21, 2013 at 05:16:02PM +0000, Arnd Bergmann wrote:
> > > The coda video codec driver depends on a mach-imx or mach-mxs specific
> > > header file "mach/iram.h". This is not available when building for
> > > multiplatform, so let us disable this driver for v3.8 when building
> > > multiplatform, and hopefully find a proper fix for v3.9.
> > > 
> > > drivers/media/platform/coda.c:27:23: fatal error: mach/iram.h: No such file or directory
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Javier Martin <javier.martin@vista-silicon.com>
> > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > > Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Err... actually, as Sascha has a proper fix for it, it should be used,
instead. So:

Nacked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Regards,
Mauro
