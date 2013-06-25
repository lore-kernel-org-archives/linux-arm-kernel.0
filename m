From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 25 Jun 2013 01:48:02 +0000
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <201306241551.19831.marex@denx.de>
References: <51A5A808.2070803@digi.com> <201306221529.53043.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFB072@039-SN2MPN1-023.039d.mgd.msft.net>
 <201306241551.19831.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803EFBC6C@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> No, I don't have this one available right now. I tried both MX23
> Olinuxino maxi
> (I just mutilated the board so that I cut traces to the USB devices on
> the board
> and routed out USB gadget connector) and a custom MX23 board.
> 
> Note that both have working USB peripheral mode in U-Boot too, but the
> driver in
> U-Boot is very minimalistic.
 
You mean, the larger data transfer with USB peripheral mode is ok at u-boot?
but it can't work at Linux Kernel?

Best regards,
Peter
