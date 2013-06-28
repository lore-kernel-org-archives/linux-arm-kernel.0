From: B29397@freescale.com (Chen Peter-B29397)
Date: Fri, 28 Jun 2013 10:46:09 +0000
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <201306281142.51676.marex@denx.de>
References: <51A5A808.2070803@digi.com> <201306271549.01136.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFF1F2@039-SN2MPN1-023.039d.mgd.msft.net>
 <201306281142.51676.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803EFF551@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> Where can I measure this?
> 
> > Two possible reasons:
> >
> > 1. You have not gpio control for vbus toggle when role switches.
> 
> This works well.
> 
> > 2. Your hardware has some problems that the vbus can't lower than 0.8v.
> 
> How can I check that?
> 

Just measure the voltage of your otg vbus pin.


Best regards,
Peter
