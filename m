From: B29397@freescale.com (Chen Peter-B29397)
Date: Sat, 22 Jun 2013 08:28:57 +0000
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <201306220433.58281.marex@denx.de>
References: <51A5A808.2070803@digi.com>
 <20130621122231.GD3523@pengutronix.de> <201306211456.31197.marex@denx.de>
 <201306220433.58281.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803EFA9DC@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> Peter, I dunno if you are already aware of it, but the USB peripheral
> mode hangs
> on MX233. It's easy to replicate for example if you try to run CDC
> ethernet over
> the USB peripheral mode, then telnet into the board and run "dmesg" .
> This will
> trigger a "larger" data transfer which will make the UDC driver hang.
> This
> doesn't happen on MX28 so it must be some MX233-specific thing.
> 

Marek, Have you tried below?

http://marc.info/?l=linux-usb&m=136537318510847&w=2

It may not the USB itself problem, the mx23's usb is almost
the same with mx28's.

Best regards,
Peter 
