From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Feb 2014 13:52:17 +0100
Subject: [PATCH v3 01/13] ARM: mvebu: rename armada-370-xp.c to
 armada-mvebu.c
In-Reply-To: <20140213125526.3af08c54@skate>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2036226.egxWL7qC66@wuerfel> <20140213125526.3af08c54@skate>
Message-ID: <201402131352.17927.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 February 2014, Thomas Petazzoni wrote:
> I believe it's a matter of taste here. Having a file named
> armada-370-xp.c that handles Armada 375 and Armada 38x looks highly
> confusing to me, and I believe both Gr?gory and Ezequiel were of the
> same opinion.

I certainly agree that it's confusing, but we also do this all the time
in the kernel.

> The number of changes to this file is very limited, so the probability
> of having a large number of complicated patches touching the same file
> being in flight is fairly low.
> 
> Maybe we can leave this taste decision to the mach-mvebu maintainers?

Definitely, sorry for being unclear here. I wasn't saying  you need to
change it, just trying to state my personal preference.

	Arnd
