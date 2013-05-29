From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 29 May 2013 08:07:55 +0000
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <20130529075044.GC3293@lukather>
References: <51A5A808.2070803@digi.com>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A3F3@039-SN2MPN1-021.039d.mgd.msft.net>
 <20130529075044.GC3293@lukather>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803E8A4D0@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> Indeed, I've been using the patchset "Add tested id switch and vbus
> connect detect support for Chipidea" from Peter for quite some time on
> top of 3.9 and it works like a charm for the gadget mode on an MX28
> platform.
> 
> BTW, Peter, I've seen that these patches are still not merged in 3.10,
> is there a reason for that? do you plan on sending a version rebased on
> top of 3.10 some time in the future? I tried to do the rebasing myself,
> but the chipidea driver seems to have changed quite heavily, which makes
> the process quite difficult when you don't know what you're doing :)
> 

I can spend few bandwidth on upstream work recently, I may have more
bandwidth after June 15th. 

Currently, we still have no conclusion for chipidea core driver's coming work,
like Device tree support, how to identify if the controller is OTG supported.

Best regards,
Peter
