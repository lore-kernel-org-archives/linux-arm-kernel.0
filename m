From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 13 Dec 2013 14:23:45 +0100
Subject: [PATCH] ARM: dts: imx53: add support for Ka-Ro TX53 modules
In-Reply-To: <20131213131507.GN24559@pengutronix.de>
References: <1386852128-32220-1-git-send-email-LW@KARO-electronics.de>
 <20131213081744.GR18380@S2101-09.ap.freescale.net>
 <20131213105417.71a42133@ipc1.ka-ro>
 <20131213121646.GU18380@S2101-09.ap.freescale.net>
 <20131213134240.595d27ae@ipc1.ka-ro>
 <20131213125719.GM24559@pengutronix.de>
 <20131213141001.389a178e@ipc1.ka-ro>
 <20131213131507.GN24559@pengutronix.de>
Message-ID: <20131213142345.414344a6@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer wrote:
> On Fri, Dec 13, 2013 at 02:10:01PM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Sascha Hauer wrote:
> > > 
> > > Actually the i.MX supports inversion in hardware. It's bit 18 in the
> > > PWMCR register.
> > > 
> > I totally missed this up to now. :(
> > Is it true for all i.MX SoCs? Or do we need to distinguish between SoCs
> > that can do the inversion and those that cannot?
> 
> It should work for >= i.MX27.
> 
OK, thanks.

> > I could provide a patch to utilize this feature, but probably not
> > before the new year. There is something called 'vacation' in the way. ;)
> 
> What's the problem? That's the time your boss can't tell you to do
> soemthing else ;)
> 
Somewhere in the world are still places where there is no internet and
no computers. ;)


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
