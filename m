From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 18 Jan 2010 01:50:37 +0530
Subject: [PATCH v2 0/2] I2C driver support for Nomadik/Ux500
In-Reply-To: <20100110131529.GE1224@trinity.fluff.org>
References: <cover.1262944133.git.srinidhi.kasagar@stericsson.com>
	<20100110131529.GE1224@trinity.fluff.org>
Message-ID: <1263759637.29557.1.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

On Sun, 2010-01-10 at 14:15 +0100, Ben Dooks wrote:
> On Fri, Jan 08, 2010 at 04:00:24PM +0530, srinidhi kasagar wrote:
> > This is the v2 version of the patch which adds support for the
> > ST-Ericsson's I2C block found in U8500/Nomadik 8815 platforms.
> > 
> > ---
> > Changelog v1->v2
> > - file rename from i2c-nmk.c to i2c-nomadik.c (Jean Delvare)
> > - remove the unnecessary return statement (Jean Delvare)
> > - kernel doc style comment fix & other fixes (Linus Walleij)
> > - Added support for 400 KHz.
> > 
> > - patch 1/2 : targets plat-nomadik folder
> > - patch v2 2/2 : fixes the above comments.
> > ---
> > 
> > srinidhi kasagar (2):
> >   ARM nomadik: add platform specific i2c configuration structures
> >   i2c: Add support for Ux500/Nomadik I2C controller
> > 
> >  arch/arm/plat-nomadik/include/plat/i2c.h |   37 ++
> >  drivers/i2c/busses/Kconfig               |    7 +
> >  drivers/i2c/busses/Makefile              |    1 +
> >  drivers/i2c/busses/i2c-nomadik.c         |  980 ++++++++++++++++++++++++++++++
> >  4 files changed, 1025 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/plat-nomadik/include/plat/i2c.h
> >  create mode 100644 drivers/i2c/busses/i2c-nomadik.c
> 
> I'll get round to reviewing the new patches in the next day or two.

Any comments on this patch set?

regards,
Srinidhi
