From: marex@denx.de (Marek Vasut)
Date: Tue, 9 Jul 2013 12:38:44 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803F39B98@039-SN2MPN1-022.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201307082256.38642.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803F39B98@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <201307091238.45019.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,
[...]

> 
> It needs to check your hardware, it is probably there is a high capacitance
> at vbus pin. Besides, the vbus should be lower than 0.8v if it is
> disconnected from pc.

I just wonder why I can no longer use device mode only after I plug in the 
adaptor for host device. Before that, I can plug in the device mode cable from 
PC all I want and this works. Then I plug in the host adaptor, that works as 
well , but if I plug in the device cable, this works no longer.

I rather suspect it might be something going on in the driver that's not right. 
I will check the hardware too, thanks.

Best regards,
Marek Vasut
