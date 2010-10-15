From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Oct 2010 15:40:07 +0200
Subject: iwmmxt signal frame handling
In-Reply-To: <AANLkTik3Brb-XbL1GkteVs_g9J3HtYsZMQogh+KR0LB0@mail.gmail.com>
References: <201010141609.10889.arnd@arndb.de>
	<AANLkTimHyhLRZwR-FRtciu+0sGYYFkAh4WfLCWwu59JA@mail.gmail.com>
	<AANLkTik3Brb-XbL1GkteVs_g9J3HtYsZMQogh+KR0LB0@mail.gmail.com>
Message-ID: <201010151540.07982.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 October 2010 15:32:04 Eric Miao wrote:
> > Acked-by: Eric Miao <eric.y.miao@gmail.com>
> >
> 
> This also passes the internal iwmmxt test, Haojian please add your
> Tested-by please.

Can you also confirm that the previous behaviour is broken?
If it is, the patch is probably a candidate for the stable trees.

	Arnd
