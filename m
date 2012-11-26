From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Nov 2012 17:49:17 +0000
Subject: [GIT PULL] ST-Ericsson Device Tree patches
In-Reply-To: <20121126160755.GD6824@gmail.com>
References: <20121120162836.GE28265@gmail.com>
 <20121126160755.GD6824@gmail.com>
Message-ID: <201211261749.17958.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 November 2012, Lee Jones wrote:
> Arnd, Olof,
> 
> The previous pull request had some duplicate patches in, which have now been
> removed. Please remove the previous branch and replace it with this one.
> 

Hi Lee,

There are quite a number of patches that got merged into next/dt after your
series. If there are just a few duplicate patches, I would prefer to leave
it there rather than replace and redo the merges on top, which has the
potential of creating other history confusion if someone based another branch
on top of next/dt without telling us.

If you still think we should replace that branch, please be more specific
about what patches are affected.

	Arnd
