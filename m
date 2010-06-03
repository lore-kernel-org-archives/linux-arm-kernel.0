From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Jun 2010 10:19:26 +0200
Subject: [alsa-devel] [PATCH v2 1/4] imx-ssi.c: add new choices to
	platform configuration
In-Reply-To: <20100601180527.GC10031@sirena.org.uk>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
	<20100601180527.GC10031@sirena.org.uk>
Message-ID: <20100603081926.GT26820@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 01, 2010 at 07:05:28PM +0100, Mark Brown wrote:
> On Thu, May 27, 2010 at 10:58:54AM +0200, Eric B??nard wrote:
> > * introduce 3 new flags to allow a more detailed configuration
> > of the SSI link :
> > 	IMX_SSI_NET : enable Network Mode
> > 	IMX_SSI_SYN : enable Synchronous Mode
> > 	IMX_SSI_USE_I2S_SLAVE : enable I2S Slave Mode
> > * new platform can use these settings without breaking actual
> > platforms.
> > 
> > Signed-off-by: Eric B??nard <eric@eukrea.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Sascha, any comments on the first couple of patches here?

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
