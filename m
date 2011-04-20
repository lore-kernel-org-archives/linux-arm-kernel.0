From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2011 11:48:45 +0200
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
Message-ID: <20110420094845.GW31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Apr 20, 2011 at 05:27:06PM +0800, Eric Miao wrote:
> On Wed, Apr 20, 2011 at 4:32 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> >> -include $(srctree)/$(MACHINE)/Makefile.boot
> >> +-include $(srctree)/$(MACHINE)/Makefile.boot
> > ? ^ Makefile grammar?
> 
> Yes. GNU make will only include the file if it _exists_.
To be more exact it will still try to "make" the include files if they
don't exist.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
