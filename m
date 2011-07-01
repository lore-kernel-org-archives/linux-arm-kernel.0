From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 1 Jul 2011 08:44:25 +0200
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for
	imx23/imx28
In-Reply-To: <201107010029.51965.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107010029.51965.arnd@arndb.de>
Message-ID: <20110701064425.GR11559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jul 01, 2011 at 12:29:51AM +0200, Arnd Bergmann wrote:
> On Thursday 30 June 2011 18:12:27 Huang Shijie-B32955 wrote:
> > 
> > I think gpmi-nfc is much better then gpmi-nand or gpmi-flash.
> 
> Then how do you want to name the near field communication drivers?
I'm not aware that the i.MX23/28 has support for near field
communication, still the i.MX28 Reference speaks about "GPMI NAND Mode".
I couldn't find "NFC" in the document. So I vote for gpmi-nand, too.
(IMHO gpmi-flash is too generic.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
