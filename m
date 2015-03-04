From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Mar 2015 00:04:01 +0100
Subject: [GIT PULL 2/2] Samsung fixes-2 for v4.0
In-Reply-To: <2064108.qlOP0oDx90@wuerfel>
References: <54F4B33E.3070803@kernel.org> <2064108.qlOP0oDx90@wuerfel>
Message-ID: <20154650.hb5Lekq8n0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 21:04:40 Arnd Bergmann wrote:
> On Tuesday 03 March 2015 04:00:14 Kukjin Kim wrote:
> > Please pull Samsung tmu and hdmi regression fixes for v4.0 and I know
> > this is quite big for fixes but I couldn't handle this series for
> > previous merge window because of dependency with driver side...sorry for
> > that and please pull so that we could support them in v4.0 on exynos
> > platforms.
> 
> What kind of dependency do you have there? It really should not be
> necessary to wait for driver changes, unless you do an incompatible
> DT binding change, which you should avoid.
> 
> I've pulled it into fixes, but won't forward it until I hear a
> good explanation.

Even with both fixes-1 and fixes-2 applied, we still get boot failures
on Exynos:

http://arm-soc.lixom.net/bootlogs/arm-soc/v4.0-rc2-104-g2ee4716/

Any idea what is going on?

	Arnd
