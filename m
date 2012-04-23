From: marex@denx.de (Marek Vasut)
Date: Mon, 23 Apr 2012 04:18:04 +0200
Subject: [PATCH 11/11] MXS: Enable USB on M28EVK
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B79445@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-12-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B79445@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201204230418.05184.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > Enable the second USB port on M28EVK board.
> > 
> > 
> > +
> > +	mx28_add_mxs_usbh(0, &m28_usb_data);
> > 
> >  }
> 
> You have enabled second port at mx28evk, why it "0"? at your
> mx28_add_mxs_usbh(0, &m28_usb_data).

Correct, I needed to test this with the gadget-capable port and this snuck in.

> 
> >  static void __init m28evk_timer_init(void)
> > 
> > --
> > 1.7.9.5

Best regards,
Marek Vasut
