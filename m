From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 26 May 2010 15:08:26 +0200
Subject: [RFC PATCH v2 1/3] ep93xx i2s audio driver
In-Reply-To: <1274878490.9346.38.camel@cndougla-ubuntu>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
	<1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
	<1274878490.9346.38.camel@cndougla-ubuntu>
Message-ID: <19453.7498.815423.705243@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +#define EP93XX_I2S_LRDIV	17
> > +#define EP93XX_I2S_SDIV		16
> 
> Looks like a minor ugly whitespace issue above.
> 
Only in the indentation of the patch...
If you look at the code with the leading '+' removed, indentation is
OK.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
