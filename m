From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Dec 2010 11:25:54 -0800
Subject: [PATCH v3] Keyboard: omap-keypad: use matrix_keypad.h
In-Reply-To: <20101222101657.GD22590@core.coreip.homeip.net>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
	<201012181639.29820.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.1.10.1012201720470.13087@esdhcp041196.research.nokia.com>
	<201012202209.24068.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.1.10.1012211150410.22164@esdhcp041196.research.nokia.com>
	<20101222101657.GD22590@core.coreip.homeip.net>
Message-ID: <20101222192554.GE7771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [101222 02:16]:
> On Tue, Dec 21, 2010 at 01:20:35PM +0200, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Mon, 20 Dec 2010, Janusz Krzysztofik wrote:
> > >Most keypad drivers make use of the <linux/input/matrix_keypad.h>
> > >defined macros, structures and inline functions.
> > >
> > >Convert omap-keypad driver to use those as well, as suggested by a
> > >compile time warning, hardcoded into the OMAP <palt/keypad.h>.
> > >
> > >Created against linux-2.6.37-rc5.
> > >Tested on Amstrad Delta.
> > >Compile tested with omap1_defconfig and omap2plus_defconfig shrinked to
> > >board-h4.
> > >
> > >Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > 
> > Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> > 
> 
> Acked-by: Dmitry Torokhov <dtor@mail.ru>
> 
> Thanks for making the changes.

Thanks everybody, applying.

Tony
