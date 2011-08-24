From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 24 Aug 2011 10:33:58 +0200
Subject: [PATCH] ARM: imx: pwm: Add support for MX53
In-Reply-To: <20110824082504.GJ16557@pengutronix.de>
References: <1314116798-12755-1-git-send-email-fabio.estevam@freescale.com>
	<20110824082504.GJ16557@pengutronix.de>
Message-ID: <20052.46966.58705.657385@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig writes:
> Hello Fabio,
> 
> On Tue, Aug 23, 2011 at 01:26:38PM -0300, Fabio Estevam wrote:
> > Instead of adding the check for MX53 CPU type, use the negative logic and let 
> > PWM to be configured for MX53 as well.
> I wonder why you prefer negative logic here. It might be shorter, but it
> is also less robust. For example it seems to me you not only added
> support for i.MX53 but also i.MX50.
> 
> The IMHO best solution would be to use device ids and get rid of
> cpu_is_mx.. completely.
> 
+1


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
