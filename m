From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 23 Sep 2013 11:25:08 +0200
Subject: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver
 implementation
In-Reply-To: <201309230955.58828.jbe@pengutronix.de>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de>
 <201309230155.04914.marex@denx.de>
 <201309230955.58828.jbe@pengutronix.de>
Message-ID: <21056.2292.381138.583291@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

J?rgen Beisert writes:
> Hi Marek,
> 
> Seems the very first touch detection does not work. A colleague just told me, 
> we have an i.MX28 based hardware here and maybe a touchscreen from a different 
> platform which maybe can be used with the i.MX28 platform. Stay tuned...
> 
> > btw. the touchscreen connection on M28EVK is pretty much the same as on
> > MX28EVK.
> 
> I think the touchscreen connection on MX28EVK is exactly the same as on 
> MX28EVK! ;) (/me needs more coffee as well)
> 
Just tested the touchscreen driver on our TX28 module and I could not
find any problems.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
