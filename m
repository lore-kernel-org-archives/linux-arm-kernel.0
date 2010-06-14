From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 14 Jun 2010 11:30:08 +0200
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <1276507378.2552.39.camel@pasglop>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
	<201006111718.47426.jeremy.kerr@canonical.com>
	<19474.172.742782.972629@ipc1.ka-ro>
	<20100611095839.GC10894@pengutronix.de>
	<19474.2817.333749.485028@ipc1.ka-ro>
	<1276319643.1962.181.camel@pasglop>
	<19477.52889.982995.407051@ipc1.ka-ro>
	<1276507378.2552.39.camel@pasglop>
Message-ID: <19477.63136.664249.167207@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin Herrenschmidt writes:
> On Mon, 2010-06-14 at 08:39 +0200, Lothar Wa?mann wrote:
> > All implementations so far use spin_lock_irq_save()!
> 
> Nothing prevents your implementation to be a tad smarter.
> 
I vote for consistency, so that device drivers can be kept arch
independent instead of having to care about implentation details of
each arch.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
