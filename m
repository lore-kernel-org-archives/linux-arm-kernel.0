From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 22:37:48 +0100
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.19 (round 3)
In-Reply-To: <20141126053819.GX22670@titan.lakedaemon.net>
References: <20141126053819.GX22670@titan.lakedaemon.net>
Message-ID: <201411282237.48754.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014, Jason Cooper wrote:
> Folks,
> 
> This is the last round of DT changes.  I kept it out separate because I
> just applied the patches tonight.  It also has a dependency on Kishon's
> guaranteed immutable branch tag, phy-dt-header.  Which, unfortunately,
> pulls in -rc4.  Hopefully this isn't a surprise to you. :)
> 
> This is an incremental pull request from a random position on the
> mvebu/dt branch up to tags/mvebu-dt-3.19-3.

I would have preferred -rc3 to earlier to avoid the backmerge, but it's
not a big issue since we already have a next/dt2 branch with another
odd dependency. I plan to submit that a little later to wait for the
other branches to get merged first and then will have to hand-craft the
pull request anyway.

Pulled into next/dt2, thanks!

	Arnd
