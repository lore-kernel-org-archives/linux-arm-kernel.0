From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 21:20:06 +0000
Subject: [GIT PULL 5/5] Clean-up for omap
In-Reply-To: <0M0SaL-1SHLTi0asf-00u7ia@mx.kundenserver.de>
References: <0M0SaL-1SHLTi0asf-00u7ia@mx.kundenserver.de>
Message-ID: <201202292120.07286.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Tony Lindgren wrote:
> This is mostly changes needed for io.h removal, and one
> patch to remove unused flag for McSPI. Note that these
> are based on RMK's for-armsoc.
> 
> Also, these cause a minor merge conflict for mach-omap2/Kconfig
> with the fixes-non-critical posted in this series of pull
> requests.

Hmm, I did not see the conflict in this one, but I saw one in the
dt branch that I fixed.

I pulled this one into next/cleanup.

	Arnd
