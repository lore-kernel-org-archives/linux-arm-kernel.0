From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 23 Apr 2012 11:59:16 +0000
Subject: [RFC PATCH 00/11 V4] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201204230418.40037.marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-1-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B79467@039-SN2MPN1-023.039d.mgd.msft.net>
 <201204230418.40037.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B798E4@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



 
> >
> > Does the udc work at this patchset? If it is, you have enabled OTG port
> > and not host 1 port, correct?
> 
> Wait for V5. Gadget mode should work, V5 should have some further rebase
> issues
> fixed.
> 
>From my point, you'd better step by step, first, mainline host and phy.
then, gadget. At last OTG if you have been interested in.

It can be easier for your mainline, as some of them have still not implemented
at your local. What's your opinion, Sascha?

 
