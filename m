From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 May 2011 18:27:02 +0800
Subject: [PATCH 1/3] ARM: mxs: remove gpio driver from mach-mxs
In-Reply-To: <201105201204.59237.arnd@arndb.de>
References: <1305885446-27404-1-git-send-email-shawn.guo@linaro.org>
	<1305885446-27404-2-git-send-email-shawn.guo@linaro.org>
	<201105201204.59237.arnd@arndb.de>
Message-ID: <20110520102701.GE27251@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 12:04:59PM +0200, Arnd Bergmann wrote:
> On Friday 20 May 2011 11:57:24 Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-mxs/Makefile       |    2 +-
> >  arch/arm/mach-mxs/gpio.c         |  331 --------------------------------------
> >  arch/arm/mach-mxs/gpio.h         |   34 ----
> >  arch/arm/mach-mxs/mach-mx28evk.c |    1 -
> >  arch/arm/mach-mxs/mm-mx23.c      |    1 -
> >  arch/arm/mach-mxs/mm-mx28.c      |    1 -
> >  6 files changed, 1 insertions(+), 369 deletions(-)
> >  delete mode 100644 arch/arm/mach-mxs/gpio.c
> >  delete mode 100644 arch/arm/mach-mxs/gpio.h
> 
> The patch looks good (removing stuff often is), but
> you are missing a changelog. Please explain why it's
> not used any more so that people can find it later
> when they only look at git but not at your original
> mail 0/3 or the entire series.
> 
That's right.  Will do.

-- 
Regards,
Shawn
