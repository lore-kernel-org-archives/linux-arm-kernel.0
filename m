From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 21:04:40 +0100
Subject: [GIT PULL 2/2] Samsung fixes-2 for v4.0
In-Reply-To: <54F4B33E.3070803@kernel.org>
References: <54F4B33E.3070803@kernel.org>
Message-ID: <2064108.qlOP0oDx90@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 March 2015 04:00:14 Kukjin Kim wrote:
> Please pull Samsung tmu and hdmi regression fixes for v4.0 and I know
> this is quite big for fixes but I couldn't handle this series for
> previous merge window because of dependency with driver side...sorry for
> that and please pull so that we could support them in v4.0 on exynos
> platforms.

What kind of dependency do you have there? It really should not be
necessary to wait for driver changes, unless you do an incompatible
DT binding change, which you should avoid.

I've pulled it into fixes, but won't forward it until I hear a
good explanation.

	Arnd
