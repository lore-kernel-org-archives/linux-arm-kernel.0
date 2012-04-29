From: B29397@freescale.com (Chen Peter-B29397)
Date: Sun, 29 Apr 2012 08:28:25 +0000
Subject: [PATCH 07/11] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <1335237523-9053-8-git-send-email-marex@denx.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335237523-9053-1-git-send-email-marex@denx.de>
 <1335237523-9053-8-git-send-email-marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B7BDA8@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> This driver will handle i.MX233/i.MX28 and I hope soon i.MX6Q. I tried to
> keep
> this separate from the MXC EHCI to avoid further polution of the MXC EHCI,
> though eventually these two might be merged.
> 
> NOTE: I still haven't figured out how to enable/disable the disconnection
> detector, it can't be enabled all the time, so I toggle PHY stuff from
> this
> driver, which I doubt is correct.
> 
 
still not understand high speed disconnect detector?
I may explain it twice during reviewing. 
