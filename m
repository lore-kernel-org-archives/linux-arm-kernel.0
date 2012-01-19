From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 19 Jan 2012 07:09:14 +0100
Subject: imx53
In-Reply-To: <1326925172.3468.300.camel@hp-dhlii>
References: <4F16E7B9.7050307@dlasys.net>
 <CAOMZO5Aqws0Ow1DxHnJ4XYfAO-zsgOuLwJueRUCBt53g1kN0bQ@mail.gmail.com>
 <1326925172.3468.300.camel@hp-dhlii>
Message-ID: <20120119060914.GX22061@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Wed, Jan 18, 2012 at 05:19:32PM -0500, David Lynch Jr. wrote:
> Linus's tree does not yet include numerous imx53 drivers.  While I can
> get it to boot, there is lots of hardware that does not work. 

Which drivers do you need?

> Freescale and others are doing imx53 driver work and most drivers are
> available somewhere, though I have not found them all in the same
> place.

That's the reason development for the mainline is done here on ALKML,
with the aim to get everything into the mainline if possible.

> Regardless, I am just looking for an appropriate reference/starting
> point. 
> 
> What would be the normal route for i.MX53 work into the kernel ?

Start with Linus' top-of-tree, discuss what you have found here on the
list (before start coding), follow the coding rules and discuss the
patches here. Don't forget to set kernel at pengutronix.de on Cc:.

Robert
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
