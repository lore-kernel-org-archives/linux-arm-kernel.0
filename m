From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 18:38:54 +0100
Subject: [GIT PULL] ARM: mvebu: new SoC support for v3.15
In-Reply-To: <20140222064748.GZ7862@titan.lakedaemon.net>
References: <20140222064748.GZ7862@titan.lakedaemon.net>
Message-ID: <201402251838.54640.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 February 2014, Jason Cooper wrote:
> Here's a cool one.  :)  We're adding support for three new Marvell SoCs
> as the chips are made available to customers.  A big thanks to Marvell
> and Free-electrons for making this happen.
> 
> The new SoCs are the Armada 375, 380, and the 385.
> 
> These patches have been in -next for at least four days and the series
> depends on the branch mvebu/soc up to tags/mvebu-soc-3.15.  I did this
> to resolve a hidden conflict.  In mvebu/soc we deleted the map_io
> handler, but when this branch renames the file to board-v7.c, it gets
> added back in.  So I've resolved this internally and added the dep.

Great stuff!

The dependency had me confused for a bit, but I guess that was just me
getting back into this.

Pulled into next/soc.

	Arnd
