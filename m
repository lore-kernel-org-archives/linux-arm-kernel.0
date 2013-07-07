From: marex@denx.de (Marek Vasut)
Date: Sun, 7 Jul 2013 03:10:00 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFF551@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306281142.51676.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFF551@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201307070310.00973.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> > Where can I measure this?
> > 
> > > Two possible reasons:
> > > 
> > > 1. You have not gpio control for vbus toggle when role switches.
> > 
> > This works well.
> > 
> > > 2. Your hardware has some problems that the vbus can't lower than 0.8v.
> > 
> > How can I check that?
> 
> Just measure the voltage of your otg vbus pin.

It's 2.5 volt for me. What am I supposed to observe happening there?

Best regards,
Marek Vasut
