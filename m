From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Sep 2011 22:13:42 +0200
Subject: [GIT PULL] dmtimer changes for v3.2 merge window
In-Reply-To: <20110928220237.GE6324@atomide.com>
References: <20110928220237.GE6324@atomide.com>
Message-ID: <201109302213.42435.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 September 2011, Tony Lindgren wrote:
> Please pull omap dmtimer changes from:
> 
> git://github.com/tmlind/linux.git dmtimer
> 
> This series completes the system timer separation from the
> driver like features. It also adds support for v2 ip that is
> available for some timers starting with omap4.
> 
> After this series arch/arm/plat-omap/dmtimer.c could be
> moved to live under drivers somewhere, but there is still
> discussion going on which features should be supported in
> a generic way.
> 
> This series depends on the cleanup you pulled earlier.
> As this series adds some new features like runtime PM suppport,
> I've kept it separate from cleanup.

Looks really nice. I've put it into another top-level branch
named next/dmtimer for now. I'm open for suggestions on whether
I should generally push branches like this separately Linuswards
or better aggregate multiple standalone features into a single
branch. 

	Arnd
