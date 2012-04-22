From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Apr 2012 20:59:50 +0000
Subject: [PULL REQUEST] stmp devices
In-Reply-To: <20120420215440.GA24875@nekote.pengutronix.de>
References: <20120420215440.GA24875@nekote.pengutronix.de>
Message-ID: <201204222059.51331.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2012, Wolfram Sang wrote:
> Hi Arnd, Olof
> 
> as requested, here is the pull request for the stmp-device-series which
> makes STMP devices mach independent (they are found on mxs and mx6
> currently). I have rebased them to 3.4-rc3 and dropped the rtc-patch,
> since it does not have a maintainer ack. I kept the I2C patch since I do
> maintain I2C myself and there are no conflicts.

I've pulled this into a next/stmp-device branch. I don't know yet if we
will combine it with other patches, probably this will get sent to
Linus as a pull request by itself.

	Arnd
