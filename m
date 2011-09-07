From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2011 11:39:39 +0200
Subject: [PATCH 0/6] add initial imx6q support
In-Reply-To: <20110907025512.GB8148@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<20110906194253.GO28816@pengutronix.de>
	<20110907025512.GB8148@S2100-06.ap.freescale.net>
Message-ID: <1431242.0sHOkKZfME@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 September 2011 10:55:12 Shawn Guo wrote:
> On Tue, Sep 06, 2011 at 09:42:53PM +0200, Uwe Kleine-K?nig wrote:
> > Hello Arnd,
> > 
> > On Tue, Sep 06, 2011 at 08:28:39PM +0200, Arnd Bergmann wrote:
> > > We've talked about it before, but I don't remember the outcome. Can you
> > > explain (and add to the above text) a short explanation of why this is
> > > in the mach-imx directory, rather than the mach-mx5 (which probably is
> > > closer to mx6 than mx3 is) or a new mach-mx6?
> > Not having looked into the patches yet, but I think mach-imx is the
> > right choice. The longterm plan for mach-mx5 is to be folded into
> > mach-imx, too. We just didn't found a volunteer for that.
> 
> My plan is to convert all the board files in mach-mx5 to imx51-dt.c
> and imx53-dt.c first, and then merge the folder into mach-imx.

Ok, sounds good.

Thanks,
	
	Arnd
