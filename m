From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Jun 2013 20:40:25 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFBC6C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306241551.19831.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFBC6C@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201306252040.25952.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> > No, I don't have this one available right now. I tried both MX23
> > Olinuxino maxi
> > (I just mutilated the board so that I cut traces to the USB devices on
> > the board
> > and routed out USB gadget connector) and a custom MX23 board.
> > 
> > Note that both have working USB peripheral mode in U-Boot too, but the
> > driver in
> > U-Boot is very minimalistic.
> 
> You mean, the larger data transfer with USB peripheral mode is ok at
> u-boot? but it can't work at Linux Kernel?

Yes, but the U-Boot driver is completely different beast.

Best regards,
Marek Vasut
