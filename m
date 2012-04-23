From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 23 Apr 2012 12:25:23 +0000
Subject: [RFC PATCH 00/11 V4] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201204231409.55131.marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <201204230418.40037.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B798E4@039-SN2MPN1-023.039d.mgd.msft.net>
 <201204231409.55131.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B79936@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> > From my point, you'd better step by step, first, mainline host and phy.
> > then, gadget. At last OTG if you have been interested in.
> 
> OTG is certainly going last, I still have to figure that out. I wanted to
> add
> gadget to see how this whole thing will work together to avoid design
> mistakes.
>
I agree. Current, it is lack of generic PHY layer, so only one PHY can
be supported at board if you want to use PHY driver. I would like to
submit some generic PHY layer code, but some many internal stuffs in hands
now.

> > It can be easier for your mainline, as some of them have still not
> > implemented at your local. What's your opinion, Sascha?
> 
> I don't follow here, what do you mean?
My original mind is step by step, but you want to implement the whole structure
to see if there is any design mistakes, it is also OK.

> 
> Best regards,
> Marek Vasut
