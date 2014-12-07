From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 7 Dec 2014 12:27:19 +0100
Subject: Do I need to invalidate caches before enabling (on ARMv7)?
In-Reply-To: <20141207111103.GV2129@pengutronix.de>
References: <20141204100357.GO2129@pengutronix.de>
 <20141206210031.GA1758@afzal-ThinkPad-R50e>
 <20141207100124.GT2129@pengutronix.de>
 <20141207105823.GA21341@lunn.ch>
 <20141207111103.GV2129@pengutronix.de>
Message-ID: <20141207112719.GB21341@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Even handling the cache being on would be possible, that would result in
> something like:

We came to the conclusion it is not possible to handle it. Something
to do with the MMU i think, but i don't remember. There is a thread in
the archive, and for the platform which i know is broken, the dts file
points to:

https://lists.debian.org/debian-arm/2012/08/msg00128.html

which contains instructions how to append a few bytes of code to the
front of the image to turn the cache off.


	Andrew
