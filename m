From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 20 Nov 2013 14:30:05 +0100
Subject: [PATCH 3/8] ASoC: fsl-ssi: Add imx50-ssi and of_device_id matching
In-Reply-To: <20131120124500.GC22308@S2101-09.ap.freescale.net>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-4-git-send-email-mpa@pengutronix.de>
 <20131120124500.GC22308@S2101-09.ap.freescale.net>
Message-ID: <20131120133005.GB10603@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Nov 20, 2013 at 08:45:01PM +0800, Shawn Guo wrote:
> On Wed, Nov 20, 2013 at 10:04:17AM +0100, Markus Pargmann wrote:
> > There is a small but significant difference between imx21-ssi and
> > imx50-ssi and above.
> 
> Markus,
> 
> Sorry, I did not point it out in the last review.  But SoC imx51 came
> out earlier than imx50, so I think imx51-ssi should be used instead as
> compatible.

Ah, I didn't know imx51 was released earlier. I will replace imx50-ssi
with imx51-ssi.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
