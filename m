From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 00:40:23 +0200
Subject: [GIT PULL RESEND] rk3288 i2s controller
In-Reply-To: <4038555.EtoLsBADBk@phil>
References: <4038555.EtoLsBADBk@phil>
Message-ID: <201409260040.23894.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014, Heiko St?bner wrote:
> While everything will of course work in next/dt of arm-soc where both my
> past pulls landed, it would produce build errors in rockchip/dts1 [if the 
> kbuild
> robot tried to "make dtbs" there] as the dma patches not in there.

The right approach for this case would be to send a pull request with this
commit based on the earlier one that has the dependency, or to send it
as a plain patch.

I've cherry-picked the one commit from this branch on top of next/dt, so
everything should be good now.

	Arnd
