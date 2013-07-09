From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 9 Jul 2013 01:05:31 +0000
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <201307082256.38642.marex@denx.de>
References: <51A5A808.2070803@digi.com> <201307070310.00973.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803F28763@039-SN2MPN1-021.039d.mgd.msft.net>
 <201307082256.38642.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803F39B98@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> > > -----Original Message-----
> > > From: Marek Vasut [mailto:marex at denx.de]
> > > Sent: Sunday, July 07, 2013 9:10 AM
> > > To: Chen Peter-B29397
> > > Cc: shawn.guo at linaro.org; Michael Grzeschik; maxime.ripard at free-
> > > electrons.com; Hector Palacios; linux-usb at vger.kernel.org;
> > > s.hauer at pengutronix.de; alexander.shishkin at linux.intel.com; Estevam
> > > Fabio-R49496; Marc Kleine-Budde; m.grzeschik at pengutronix.de; linux-
> arm-
> > > kernel at lists.infradead.org
> > > Subject: Re: Chipidea usb otg support for IMX/MXS (device
> functionality)
> > >
> > > Hi Peter,
> > >
> > > > > Where can I measure this?
> > > > >
> > > > > > Two possible reasons:
> > > > > >
> > > > > > 1. You have not gpio control for vbus toggle when role switches.
> > > > >
> > > > > This works well.
> > > > >
> > > > > > 2. Your hardware has some problems that the vbus can't lower
> than
> > >
> > > 0.8v.
> > >
> > > > > How can I check that?
> > > >
> > > > Just measure the voltage of your otg vbus pin.
> > >
> > > It's 2.5 volt for me. What am I supposed to observe happening there?
> >
> > http://marc.info/?l=linux-usb&m=137242465920952&w=2
> 
> Dang, must have missed that one, sorry.
> 
> The VBUS is slowly discharging from around 5V to 2.5V , what does that
> tell me?
> 

It needs to check your hardware, it is probably there is a high capacitance at
vbus pin. Besides, the vbus should be lower than 0.8v if it is disconnected from
pc.

Best regards,
Peter
