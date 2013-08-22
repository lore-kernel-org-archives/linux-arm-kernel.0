From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Aug 2013 14:46:40 +0900
Subject: SHMobile Compatibility String Inconsistencies
Message-ID: <20130822054639.GE11086@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent, Hi Guennadi, Hi All,

Olof has brought to my attention that there is some inconsistency
in the way that compatibility strings for SHMobile are named and he
has asked us to clean things up for v3.12.

Looking through arch/arm/boot/dts/ I see that we have:

1. {gpio,pfc}-r8aXXXX and;
2. r8aXXXX-sdhi

The inconsistency that Olof has asked us to resolve is that we
should either use r8aXXXX- or -r8aXXXX. Not both.

It seems to me that neither option is inherently better than the other
so we should just choose the path of least resistance to make things
consistent.

Laurent, Guennadi, do you have any opinions on if it would
be easier to change the GPIO and PFC compatibility strings;
or to change the SDHI compatibility strings?

Ideally I would like you to come to some sort of consensus and send
patches.

Thanks
