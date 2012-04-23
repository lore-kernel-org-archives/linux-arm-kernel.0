From: marex@denx.de (Marek Vasut)
Date: Mon, 23 Apr 2012 14:40:11 +0200
Subject: [RFC PATCH 00/11 V4] MXS: Add i.MX28 USB Host driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B79936@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <201204231409.55131.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B79936@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201204231440.11469.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > > From my point, you'd better step by step, first, mainline host and phy.
> > > then, gadget. At last OTG if you have been interested in.
> > 
> > OTG is certainly going last, I still have to figure that out. I wanted to
> > add
> > gadget to see how this whole thing will work together to avoid design
> > mistakes.
> 
> I agree. Current, it is lack of generic PHY layer, so only one PHY can
> be supported at board if you want to use PHY driver.

Yes, that's indeed a problem. Doesn't seem to be a hard one though.

> I would like to
> submit some generic PHY layer code, but some many internal stuffs in hands
> now.

Good :)
> 
> > > It can be easier for your mainline, as some of them have still not
> > > implemented at your local. What's your opinion, Sascha?
> > 
> > I don't follow here, what do you mean?
> 
> My original mind is step by step, but you want to implement the whole
> structure to see if there is any design mistakes, it is also OK.

Yes exactly ... I believe it's better this way to see how it works out. I'll try 
OTG tonight if nothing more important pops up.

> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
