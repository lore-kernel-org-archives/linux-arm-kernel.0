From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 Mar 2011 09:33:58 +0100
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
In-Reply-To: <20110311204405.GE20247@sortiz-mobl>
References: <20110304080653.3f2c3f19@debxo>
	<20110307085358.GM29521@pengutronix.de>
	<20110311204405.GE20247@sortiz-mobl>
Message-ID: <20110315083358.GI29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi samuel,

On Fri, Mar 11, 2011 at 09:44:05PM +0100, Samuel Ortiz wrote:
> Hi Sascha,
> 
> On Mon, Mar 07, 2011 at 09:53:58AM +0100, Sascha Hauer wrote:
> > On Fri, Mar 04, 2011 at 08:06:53AM -0800, Andres Salomon wrote:
> > > Note that this relies on stuff currently in mfd's next tree, but this
> > > is also a newer driver.  I'm not sure which tree it should go through,
> > > as it's a problem that shows up in next.
> > 
> > Please ping me again when the mfd tree is in Linus master. I see no
> > other chance fixing this on my side other than removing regulator
> > support for efika completely for now. So I guess you have to live with
> > the compile breakage for some time.
> It would probably make sense for me to carry this driver then. Sascha, would
> you be ok with it ? If that's so, could you please point me at a git commit
> from your tree ?

The file which is changed only got created in my tree, so no way for you
to apply it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
