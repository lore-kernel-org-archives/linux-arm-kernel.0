From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Feb 2012 11:58:23 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120213144820.GA3494@opensource.wolfsonmicro.com>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
Message-ID: <20120214105823.GS3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 06:48:21AM -0800, Mark Brown wrote:
> On Mon, Feb 13, 2012 at 09:27:41AM +0100, Sascha Hauer wrote:
> 
> > I really don't want to have that much code for saying 'we don't have a
> > regulator, just make this stupid driver happy'. This is fine for one
> > board, but not for the more than a dozen users of this driver in the tree.
> > We should really add a helper to simplify this.
> 
> If the board really has so few software controlled regulators then they
> should just be using the dummy regulator support which already exists,
> someone should just add a knob to turn it on automatically.

I thought we agree that generally turning on the dummy regulator is a
bad idea. Now you are advocating for the dummy regulator again.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
