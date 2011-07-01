From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 16:52:48 +0200
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for
	imx23/imx28
In-Reply-To: <4E0D8C04.6010409@freescale.com>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107010029.51965.arnd@arndb.de> <4E0D8C04.6010409@freescale.com>
Message-ID: <201107011652.48869.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011, Huang Shijie wrote:
> > On Thursday 30 June 2011 18:12:27 Huang Shijie-B32955 wrote:
> >> I think gpmi-nfc is much better then gpmi-nand or gpmi-flash.
> > Then how do you want to name the near field communication drivers?
> >
> what's meaning of "near field communication" ?

See http://en.wikipedia.org/wiki/Near_field_communication

It's likely to be present in most future mobile phones. Think of it as
a combination of bluetooth and RFID (oversimplified).

	Arnd
