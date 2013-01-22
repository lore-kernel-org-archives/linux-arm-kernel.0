From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 15:41:05 +0000
Subject: [PATCH 09/15] media: coda: don't build on multiplatform
In-Reply-To: <20130122082158.GC9414@pengutronix.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-10-git-send-email-arnd@arndb.de>
 <20130122082158.GC9414@pengutronix.de>
Message-ID: <201301221541.05636.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Sascha Hauer wrote:
> On Mon, Jan 21, 2013 at 05:16:02PM +0000, Arnd Bergmann wrote:
> > The coda video codec driver depends on a mach-imx or mach-mxs specific
> > header file "mach/iram.h". This is not available when building for
> > multiplatform, so let us disable this driver for v3.8 when building
> > multiplatform, and hopefully find a proper fix for v3.9.
> > 
> > drivers/media/platform/coda.c:27:23: fatal error: mach/iram.h: No such file or directory
> 
> I just sent a pull request for this with a proper fix.

Ok, even better. Thanks for taking care of it!

	Arnd
