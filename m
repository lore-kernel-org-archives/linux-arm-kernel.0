From: marex@denx.de (Marek Vasut)
Date: Mon, 23 Apr 2012 14:09:54 +0200
Subject: [RFC PATCH 00/11 V4] MXS: Add i.MX28 USB Host driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B798E4@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <201204230418.40037.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B798E4@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201204231409.55131.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > > Does the udc work at this patchset? If it is, you have enabled OTG port
> > > and not host 1 port, correct?
> > 
> > Wait for V5. Gadget mode should work, V5 should have some further rebase
> > issues
> > fixed.
> 
> From my point, you'd better step by step, first, mainline host and phy.
> then, gadget. At last OTG if you have been interested in.

OTG is certainly going last, I still have to figure that out. I wanted to add 
gadget to see how this whole thing will work together to avoid design mistakes.

> It can be easier for your mainline, as some of them have still not
> implemented at your local. What's your opinion, Sascha?

I don't follow here, what do you mean?

Best regards,
Marek Vasut
