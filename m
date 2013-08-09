From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 9 Aug 2013 14:37:12 +0200
Subject: [PATCH v10 3/7] ASoC: imx-audmux: Read default configuration
 from devicetree
In-Reply-To: <20130806165746.GH6427@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-4-git-send-email-mpa@pengutronix.de>
 <20130806165746.GH6427@sirena.org.uk>
Message-ID: <20130809123712.GD13664@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 05:57:46PM +0100, Mark Brown wrote:
> On Sat, Jul 27, 2013 at 01:31:52PM +0200, Markus Pargmann wrote:
> > Adds a function to parse a default port configuration from devicetree.
> 
> Applied, thanks - this is a really nice improvement.

Sorry, but I noticed two bugs in this patch, I will send a fixup.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
