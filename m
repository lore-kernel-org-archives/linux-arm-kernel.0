From: marex@denx.de (Marek Vasut)
Date: Sat, 22 Jun 2013 15:29:52 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFA9DC@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306220433.58281.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFA9DC@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201306221529.53043.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> > Peter, I dunno if you are already aware of it, but the USB peripheral
> > mode hangs
> > on MX233. It's easy to replicate for example if you try to run CDC
> > ethernet over
> > the USB peripheral mode, then telnet into the board and run "dmesg" .
> > This will
> > trigger a "larger" data transfer which will make the UDC driver hang.
> > This
> > doesn't happen on MX28 so it must be some MX233-specific thing.
> 
> Marek, Have you tried below?
> 
> http://marc.info/?l=linux-usb&m=136537318510847&w=2
> 
> It may not the USB itself problem, the mx23's usb is almost
> the same with mx28's.

This also happens on a different MX23-based board for me. This other board I 
tried has mDDR DRAM and the DRAM is operating correctly. The 96MHz thing people 
complained about in the Olimex forum is resolved now. 

Best regards,
Marek Vasut
