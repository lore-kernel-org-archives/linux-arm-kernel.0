From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 19 Dec 2013 09:25:25 +0100
Subject: [PATCH 2/2] ARM: dts: tps65910 backup battery regulator
In-Reply-To: <20131218162546.GY28455@sirena.org.uk>
References: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
 <1387378208-26841-2-git-send-email-mpa@pengutronix.de>
 <20131218162546.GY28455@sirena.org.uk>
Message-ID: <20131219082525.GE23493@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 04:25:46PM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 03:50:08PM +0100, Markus Pargmann wrote:
> > This patch adds a devicetree node for the backup battery regulator.
> 
> Your previous patch missed an update to the binding documentation for
> the regulator driver.

Right, thank you, I added vbb to the tps65910 mfd binding documentation.

Regards,

Markus



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
